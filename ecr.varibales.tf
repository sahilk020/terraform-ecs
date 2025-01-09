variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"  # Default region (can be overridden)
}
variable "repository" {
  description = "The ECS Task Definition for the service"
  type        = string
  default     = "preprod/mocrm"  # Replace with your actual task definition ARN
}
