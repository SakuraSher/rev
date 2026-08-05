resource "aws_iam_role" "execution_role" {
    name = "ecsTaskExecutionRole1"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com" 
                }
            }
        ]
    })
                    
}

# resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
#     role       = aws_iam_role.execution_role.name
#     policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

resource "aws_iam_policy" "task_execution_policy" {
  name        = "ecs-task-execution-policy"
  description = "Policy for ECS task execution role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.ecsloggroup.arn}:*"
      }
    ]
  })

}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.task_execution_policy.arn
}