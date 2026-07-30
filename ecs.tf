resource "aws_ecs_cluster" "ecs_cluster" {
    name = "ecs-cluster"
    
}

resource "aws_ecs_task_definition" "ecs_task" {
    family = "ecsapp"
    network_mode = "awsvpc" #added
    requires_compatibilities = ["FARGATE"] #added
      
     container_definitions = jsonencode([
    {
      name      = "app"
      image     = "linktoecrimage"
      cpu       = 1024
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DB_LINK"
          value = "will fill it later" # fetch from secret manager
        }]
      logConfiguration = { #added
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/ecsapp"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        

      } 
    }
    

    
    execution_role_arn = aws_iam_role.execution_role.arn
   
}

resource "aws_ecs_service" "service"{
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 2
  iam_role        = aws_iam_role.execution_role.arn
  #depends_on      = [aws_iam_role_policy.foo]

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "app"
    container_port   = 8000
  
  }

 #added
 network_configuration {
    subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  depends_on = [aws_alb_listener.http]
}