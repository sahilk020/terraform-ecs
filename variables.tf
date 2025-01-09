# Variable for AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"  # Default region (can be overridden)
}

# Variable for ECS Cluster Name
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "preprod-cluster"
}

# Variable for CloudWatch Log Group Name
variable "log_group_name" {
  description = "The name of the CloudWatch log group for ECS service logs"
  type        = string
  default     = "/ecs/preprod/mocrm"
}

# Variable for VPC ID
variable "vpc_id" {
  description = "The VPC ID where ECS resources will be deployed"
  type        = string
  default     = "vpc-0695c34c5326726e1"  # Update with your VPC ID
}

# Variable for Subnet IDs (Private Subnets)
variable "subnet_ids" {
  description = "The list of private subnet IDs for the ECS service"
  type        = list(string)
  default     = ["subnet-03a28931e61865079", "subnet-042ddedac5e298678"]  # Update with your subnet IDs
}

# Variable for Security Group IDs (for ECS Service)
variable "security_group_ids" {
  description = "The list of security group IDs for the ECS service"
  type        = list(string)
  default     = ["sg-051e91d688b67cb68"]  # Your provided security group ID
}

# Variable for ECS Service Task Definition
variable "task_definition" {
  description = "The ECS Task Definition for the service"
  type        = string
  default     = "preprod-mocrm"  # Replace with your actual task definition ARN
}

variable "execution_role_arn" {
  description = "The ECS Task Definition for the service"
  type        = string
  default     = "arn:aws:iam::484907490372:role/ecsTaskExecutionRole"  # Replace with your actual task definition ARN
}
variable "task_role_arn" {
  description = "The ECS Task Definition for the service"
  type        = string
  default     = "arn:aws:iam::484907490372:role/ecsTaskExecutionRole"  # Replace with your actual task definition ARN
}
variable "container_image" {
    description = "image"
    type = string
    default = ""
  
}
