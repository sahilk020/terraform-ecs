terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"  # Ensure to use an appropriate version
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
}

# Define the ECS Cluster
resource "aws_ecs_cluster" "preprod-cluster" {
  name = var.ecs_cluster_name
}

# Define CloudWatch Log Group for ECS Task Logging
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = var.log_group_name
}

# Define ECS Cluster Capacity Providers
resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.preprod-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "preprod_mocrm" {
  family                   = "preprod-mocrm"
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  task_role_arn            = "arn:aws:iam::484907490372:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::484907490372:role/ecsTaskExecutionRole"

  runtime_platform {
    cpu_architecture       = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = <<DEFINITION
  [
    {
      "name": "preprod-mocrm",
      "image": "484907490372.dkr.ecr.eu-central-1.amazonaws.com/preprod/mocrm:latest",
      "cpu": 1024,
      "memory": 2048,
      "essential": true,
      "portMappings": [
        {
          "name": "preprod-mocrm",
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/preprod/mocrm",
          "mode": "non-blocking",
          "awslogs-create-group": "true",
          "max-buffer-size": "5m",
          "awslogs-region": "eu-central-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "linuxParameters": {
        "initProcessEnabled": true
      }
    }
  ]
  DEFINITION
}

# Define ECS Service using the ECS Cluster and Task Definition
resource "aws_ecs_service" "preprod_service" {
  name            = "preprod-service"
  cluster         = aws_ecs_cluster.preprod-cluster.id  # Reference the ECS Cluster here
  task_definition = aws_ecs_task_definition.preprod_mocrm.arn  # Reference task definition here

  desired_count   = 1  # Number of desired tasks to run (should be greater than 0)
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids        # Reference the subnet IDs from variables
    security_groups = var.security_group_ids  # Reference the security group IDs from variables
    assign_public_ip = true # Ensures it is a private subnet, set true if you want public access
  }

  # Optional: Set deployment configurations
  deployment_controller {
    type = "ECS"
  }
}
