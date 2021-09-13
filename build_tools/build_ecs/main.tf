variable "aws_account_id" {}
variable "app_name" {}

module "network" {
  source = "./network"
  app_name = var.app_name
}

## Cluster
resource "aws_ecs_cluster" "default" {
  name = var.app_name

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}
 
## Task
resource "aws_ecs_task_definition" "default" {
  family                             = var.app_name
  requires_compatibilities           = ["FARGATE"]
  network_mode                       = "awsvpc"
  task_role_arn                      = "arn:aws:iam::${var.aws_account_id}:role/ecsExecRole"
  execution_role_arn                 = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  cpu                                = 256
  memory                             = 512
  container_definitions              = templatefile("./container_definitions.json", {aws_account_id = var.aws_account_id})
}

## Service
resource "aws_ecs_service" "default" {
  cluster                            = aws_ecs_cluster.default.id
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 1
#  launch_type                        = "FARGATE"
  name                               = var.app_name
 
  network_configuration {
    assign_public_ip = "true"
    subnets = [module.network.aws_subnet_id]
    security_groups = [module.network.aws_security_group_id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 100
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 0
  }
 
  task_definition = aws_ecs_task_definition.default.arn

  enable_execute_command = "true"
}
