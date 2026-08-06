# resource "aws_db_subnet_group" "ecs_rds_subnet_group" {
#     name = "ecs-rds-subnet-group"
#     subnet_ids = [aws_subnet.rds_subnet1.id, aws_subnet.rds_subnet2.id]
#     tags = {
#         Name = "ecs-rds-subnet-group"
#     }
# }

# resource "random_password" "password"{
#     length = 16
#     special = false
#     override_special = "asdfgjhkqwrtopASHLSGSAGNAX12345667890"
# }

# resource "aws_db_instance" "ecs_rds"{
#     db_name = "mydb"
#     engine = "postgres"
#     engine_version =  "15.17"
#     username = "postgres"
#     password = random_password.password.result
#     instance_class = "db.t3.micro"
#     storage_type = "gp2"
#     allocated_storage = 20
#     network_type = "IPV4"
#     db_subnet_group_name = aws_db_subnet_group.ecs_rds_subnet_group.name
#     vpc_security_group_ids = [aws_security_group.rds_sg.id]
#     publicly_accessible = false
#     multi_az = false
#     backup_retention_period = 7
#     skip_final_snapshot = true
#     apply_immediately = true
# }

