resource "aws_ecs_cluster" "prj_api_ecs_cluster_dev" {
  name = "${var.project_name}-api-ecs-cluster-${var.project_env}"
}


resource "aws_ecs_task_definition" "prj_api_ecs_task_def_dev" {
  family                   = "${var.project_name}-api-ecs-task-def-${var.project_env}"
  network_mode             = "awsvpc"
  container_definitions    = <<task_definitions
[
  {
    "name": "${var.project_name}-api-ecs-${var.project_env}",
    "image": "${var.ecr_image}:latest",
    "memory": 2048,
    "cpu": 1024,
    "secrets": [],
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.aws_region}",
        "awslogs-group": "${aws_cloudwatch_log_group.prj_api_ecs_loggrp_dev.name}",
        "awslogs-stream-prefix": "ecs_api"
      }
    }
  }
]
task_definitions
  task_role_arn            = aws_iam_role.prj_api_ecs_role_task_dev.arn
  execution_role_arn       = aws_iam_role.prj_api_ecs_role_exec_dev.arn
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [container_definitions]
  }
}

resource "aws_ecs_service" "prj_api_ecs_svc_dev" {
  name                   = "${var.project_name}-api-ecs-svc-${var.project_env}"
  cluster                = aws_ecs_cluster.prj_api_ecs_cluster_dev.id
  enable_execute_command = true
  task_definition        = aws_ecs_task_definition.prj_api_ecs_task_def_dev.arn
  desired_count          = 1
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  scheduling_strategy = "REPLICA"
  launch_type         = "FARGATE"
  network_configuration {
    subnets         = [data.aws_subnet.prj_pubsub01_dev.id]
    security_groups = [aws_security_group.prj_api_ecs_sg_dev.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.prj_api_ecs_trg_dev.arn
    container_name   = "${var.project_name}-api-ecs-${var.project_env}"
    container_port   = 3000
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancer, task_definition]
  }
  depends_on = [aws_lb.prj_api_ecs_lb_dev]
  tags = {
    Name = "${var.project_name}-ecs_svc-${var.project_env}"
  }
}

output "prj_api_ecs_svc_dev_name" {
  value = aws_ecs_service.prj_api_ecs_svc_dev.name
}

output "prj_api_ecs_cluster_dev_name" {
  value = aws_ecs_cluster.prj_api_ecs_cluster_dev.name
}
