resource "aws_secretsmanager_secret" "db_secret"{
    name = "db-env-secret"
    description = "db-env-string"
    recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_secret"{
    secret_id = aws_secretsmanager_secret.db_secret.id
    secret_string = "postgresql://${aws_db_instance.ecs_rds.username}:${random_password.password.result}@${aws_db_instance.ecs_rds.address}:5432/${aws_db_instance.ecs_rds.db_name}"
}