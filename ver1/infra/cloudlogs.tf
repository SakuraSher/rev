resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = "ecsapplogs"
  retention_in_days = 7
}