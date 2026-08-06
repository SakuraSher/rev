resource "aws_cloudwatch_log_group" "ecsloggroup" {
  name              = "/ecs/ecstasker"
  retention_in_days = 7
   tags = {
    Name = "/ecs/ecstasker"
  }
}

output "ecs_log_group_name" {
  value = aws_cloudwatch_log_group.ecsloggroup.name
}