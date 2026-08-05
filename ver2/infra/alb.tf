resource "aws_alb" "ecs_lb"{
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application" #optional
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id]

  tags = {
    Name = "ecsALB"
  }
}

resource "aws_alb_listener" "ecs_listener" {
  load_balancer_arn = aws_alb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_tg.arn
  }
}

resource "aws_alb_target_group" "ecs_tg" {
  name     = "ecs-tg"
  port     = 8000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    matcher             = "200"
  }
  tags = {
    Name = "april-2026-bootcamp-alb-target-group"
  }
}