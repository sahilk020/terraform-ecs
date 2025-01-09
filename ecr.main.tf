terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_repository" {
  name                = var.repository  # Replace with the name of your ECR repository
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "my-repository"
    Environment = "Preprod"
  }
}
