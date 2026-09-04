variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet"{
    type = list(string)
    description = "List of public subnet CIDR blocks"
}
variable "private_subnet"{
    type = list(string)
    description = "List of private subnet CIDR blocks"
}
variable "environment" {
    description = "Environment name (e.g., dev, prod)"
    type = string
    default     = "dev"
}