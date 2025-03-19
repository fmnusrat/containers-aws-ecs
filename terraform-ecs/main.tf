provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = var.ecr_repository
}

resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = var.ecs_cluster
}

resource "aws_ecs_task_definition" "ecs_task_def" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.ecr_registry}/${var.ecr_repository}:latest"
      essential = true
      memory    = 1024
      cpu       = 512
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}


resource "aws_ecs_service" "my_ecs_service" {
  name            = var.ecs_service
  cluster  = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.ecs_task_def.arn}:latest"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
}