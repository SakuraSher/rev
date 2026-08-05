resource "aws_cloudwatch_log_group" "ecsloggroup" {
  name              = "/ecs/ecs-task"
  retention_in_days = 7
   tags = {
    Name = "/ecs/ecs-task"
  }
}

output "ecs_log_group_name" {
  value = aws_cloudwatch_log_group.ecsloggroup.name
}