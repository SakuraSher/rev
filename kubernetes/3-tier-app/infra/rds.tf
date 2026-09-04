# 2 private subnets
# create subnet group from that
#rds instance in that subnet group
# random password for rds instance
# store cred in secrets manager
# same vpc as EKS cluster
# KMS keys for encryption
resource "aws_security_group" "rds_sg" {
    name        = "${var.environment}-${var.vpc_name}-rds-sg"
    description = "Security group for RDS instance"
    vpc_id      = data.aws_vpc.main.id

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_subnet" "rds_subnet_1"{
    cidr_block = "10.0.5.0/24"
    vpc_id = data.aws_vpc.main.id
    availability_zone = "ap-south-1a"
}

resource "aws_subnet" "rds_subnet_2"{
    cidr_block = "10.0.6.0/24"
    vpc_id = data.aws_vpc.main.id
    availability_zone = "ap-south-1b"
}

resource "aws_db_subnet_group" "rds_subnet_group"{
    name =  "${var.environment}-${var.vpc_name}-rds-subnet-group"
    subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
}
resource "aws_kms_key" "rds_encryption_key" {
    description             = "KMS key for RDS encryption"
    deletion_window_in_days = 7
        tags = {
            Name = "3-tier-app-rds-encryption-key"  
        }
    }
resource "aws_db_instance" "rds"{
    db_name = "appdb"
    identifier = "${var.environment}-${var.vpc_name}-rds"
    allocated_storage = 20
    storage_encrypted = true
    backup_retention_period = 1
    kms_key_id = aws_kms_key.rds_encryption_key.arn
    engine = "postgres"
    engine_version = "17.5"
    instance_class = "db.t3.medium"
    db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    username = var.rds_username
    password = random_password.rds_password.result
    skip_final_snapshot = true
  


}

resource "random_password" "rds_password" {
    length = 16
    special = true
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
    secret_id     = aws_secretsmanager_secret.rds_secret.id
    secret_string = "postgresql://${var.rds_username}:$(random_password.rds_password.result)@${aws_db_instance.rds.address}:5432/appdb"
    
}

resource "aws_secretsmanager_secret" "rds_secret" {
    name = "${var.environment}-${var.vpc_name}-rds-secret"
    description = "RDS credentials for ${var.environment} environment"
    recovery_window_in_days = 7
    # lifecycle {
    #     prevent_destroy = true
    # }
    
}