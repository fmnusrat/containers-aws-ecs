variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "ap-south-1"
}

variable "ecr_registry" {
  description = "The ECR registry URL"
  default     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com"
}

variable "ecr_repository" {
  description = "The name of the ECR repository"
  default     = "my-ecr-repo"
}

variable "image_tag" {
  description = "The image tag"
  default     = "latest"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "my-ecs-cluster"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  default     = "my-ecs-service"
}

variable "ecs_task_family" {
  description = "The family of the ECS task"
  default     = "ecs-task-def"
}

variable "container_name" {
  description = "The name of the container"
  default     = "my-container"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  default     = "vpc-0939e64691c6586a8"
}

variable "security_group_id" {
  description = "The ID of the security group"
  default     = "sg-06ed90ac9f1974153"
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
  default     = ["subnet-047b28549eddad8ec", "subnet-059136a6f03d0750e", "subnet-08d08bb5426cb7759"]
}

variable "execution_role_arn" {
  description = "The ARN of the execution role"
  default     = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
}

variable "task_role_arn" {
  description = "The ARN of the task role"
  default     = "arn:aws:iam::123456789012:role/ecsTaskRole"
}

