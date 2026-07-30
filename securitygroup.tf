resource "aws_security_group" "ecs_sg"{
    name = "ecs-sg"
    description = "Security group for private subnet"
    vpc_id = aws_vpc.vpc.id

}


resource "aws_vpc_security_group_ingress_rule" "private_ingress_rule1"{
    security_group_id = aws_security_group.ecs_sg.id
    referenced_security_group_id = aws_security_group.alb_sg.id
    from_port = 8000
    ip_protocol = "tcp"
    to_port = 8000

}

resource "aws_vpc_security_group_egress_rule" "private_egress_rule"{
    security_group_id = aws_security_group.ecs_sg.id
    cidr_ipv4 ="0.0.0.0/0"
    ip_protocol = "-1"
}


# ALB Security Group
resource "aws_security_group" "alb_sg"{
    name = "alb-sg"
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_security_group" "rds_sg"{
    name = "rds-sg"
    vpc_id = aws_vpc.vpc.id

    ingress {
        security_groups = [aws_security_group.ecs_sg.id]
        from_port = 5432
        to_port = 5432
        protocol = "tcp"

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
}