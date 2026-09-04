resource "aws_ecr_repository" "backend" {
    name = var.backend_repo
    }

resource "aws_ecr_repository" "frontend" {
    name = var.frontend_repo
    }