variable "aws_account_id" {}
variable "app_name" {}
    
module "network" {
  source = "./network"
  app_name = ${var.app_name}
}

## Cluster
resource "aws_ecs_cluster" "default" {
  name = ${var.app_name}
}
 
## Task
resource "aws_ecs_task_definition" "default" {
  family                             =  ${var.app_name}
  requires_compatibilities           = ["FARGATE"]
  network_mode                       = "awsvpc"
  task_role_arn                      = "arn:aws:iam::${var.aws_account_id}:role/ecsExecRole"
  execution_role_arn                 = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  cpu                                = 512
  memory                             = 1024
  container_definitions              = templatefile("./container_definitions.json", {aws_account_id = &{var.aws_account_id}})
}

## Service
resource "aws_ecs_service" "default" {
  cluster                            = aws_ecs_cluster.default.id
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 1
  launch_type                        = "FARGATE"
  name                               = ${var.app_name}
 
  network_configuration {
    subnets = [module.network.aws_subnet.id]
    security_groups = [module.network.aws_security_group.id]
  }
 
  task_definition = aws_ecs_task_definition.default.arn
}