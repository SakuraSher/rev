variable vpc_name {
  description = "Name of the VPC to use"
  type        = string
  default     =  "asg3" #"dev-proj-abc"
}

variable region {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "rds_username" {
  description = "Username for the RDS instance"
  type        = string
  default     = "postgres"
}

variable "backend_repo" {
  description = "Name of the ECR repository for the backend"
  type        = string
  default     = "3tier-backend"
}

variable "frontend_repo" {
  description = "Name of the ECR repository for the frontend"
  type        = string
  default     = "3tier-frontend"
}

variable "namespace" {
  description = "Kubernetes namespace to deploy resources"
  type        = string
  default     = "devopsnamespace"
}