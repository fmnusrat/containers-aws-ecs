provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my-ecr-repo" {
  name = var.ecr_repository
}

resource "aws_ecs_cluster" "my-ecs-cluster" {
  name = var.ecs_cluster
}

data "template_file" "task_definition" {
  template = file("./task_definition.json")

  vars = {
    ecr_registry     = aws_ecr_repository.ecr_repo.repository_url
    ecr_repository   = var.ecr_repository
    image_tag        = var.image_tag
    execution_role_arn = var.execution_role_arn
    task_role_arn    = var.task_role_arn
    container_name   = var.container_name
    log_group        = var.log_group
    log_region       = var.aws_region
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = data.template_file.task_definition.rendered
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
}