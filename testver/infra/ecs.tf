resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
  
  
}

resource "aws_ecs_cluster_capacity_providers" "fargate"{
  cluster_name = aws_ecs_cluster.ecs-cluster.name
  capacity_providers = ["FARGATE","FARGATE_SPOT"]

}

resource "aws_ecs_task_definition" "ecs_task"{
    family = "ecstasker"
    network_mode = "awsvpc"
    cpu = 512
    memory = 2048
    requires_compatibilities = ["FARGATE"]
    runtime_platform {
      operating_system_family = "LINUX"
      cpu_architecture = "X86_64"
    }
    execution_role_arn = aws_iam_role.execution_role.arn
    container_definitions = jsonencode([
      {
        name = "2tier"
        image = var.image_name
        essential = true
        portMappings = [
          {
            containerPort = 8000
            hostPort = 8000
            protocol = "tcp"
            
          }
        ]
        environment = [
          {
            name = "DB_LINK"
            value = aws_secretsmanager_secret_version.db_secret.secret_string
          }
        ]

        logging = {
          logDriver = "awslogs"
          options = {
            awslogs-group = aws_cloudwatch_log_group.ecsloggroup.name
            awslogs-region = "ap-south-1"
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  task_definition = aws_ecs_task_definition.ecs_task.family
  cluster        = aws_ecs_cluster.ecs-cluster.id
  launch_type     = "FARGATE"
  desired_count   = 1
  availability_zone_rebalancing = "DISABLED"
 

  network_configuration {
    subnets         = [aws_subnet.private_subnet3.id, aws_subnet.private_subnet4.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  # load_balancer {
  #   target_group_arn = aws_alb_target_group.ecs_tg.arn
  #   container_name   = "2tier"
  #   container_port   = 8000
  # }

  #depends_on = [aws_alb_listener.ecs_listener,aws_db_instance.ecs_rds,aws_secretsmanager_secret_version.db_secret]

}