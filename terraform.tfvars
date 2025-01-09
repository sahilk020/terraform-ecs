aws_region        = "eu-central-1"
ecs_cluster_name  = "preprod-cluster"
log_group_name    = "/ecs/preprod/mocrm"
subnet_ids        = ["subnet-03a28931e61865079", "subnet-042ddedac5e298678"] 
security_group_ids = ["sg-051e91d688b67cb68"]  # Your provided security group ID
task_definition   = "preprod-mocrm"
