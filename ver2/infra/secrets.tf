resource "aws_secretsmanager_secret" "db_secret"{
    name = "db-env-string2"
    description = "db-env-string"
}

resource "aws_secretsmanager_secret_version" "db_secret"{
    secret_id = aws_secretsmanager_secret.db_secret.id
    secret_string = "postgresql://${aws_db_instance.ecs_rds.username}:${random_password.password.result}@${aws_db_instance.ecs_rds.address}:5432/${aws_db_instance.ecs_rds.db_name}"
}