#vpc variables
variable "public_subnet1_cidr" {
    description = "CIDR block for the public subnet 1"
    type        = string
    default     = "10.0.1.0/24"
}
variable "public_subnet2_cidr" {
    description = "CIDR block for the public subnet 2"
    type        = string
    default     = "10.0.2.0/24"
}
variable "public_subnet3_cidr" {
    description = "CIDR block for the public subnet 3"
    type        = string
    default     = "10.0.3.0/24"
}
variable "public_subnet4_cidr" {
    description = "CIDR block for the public subnet 4"
    type        = string
    default     = "10.0.4.0/24"
}

variable "rds_subnet_cidr1" {
    description = "CIDR block for the public subnet 4"
    type        = string
    default     = "10.0.5.0/24"
}


variable "rds_subnet_cidr2" {
    description = "CIDR block for the public subnet 4"
    type        = string
    default     = "10.0.6.0/24"
}

variable "image_name" {
    description = "Name of the application"
    type        = string
    default     = "167251111434.dkr.ecr.ap-south-1.amazonaws.com/bootcamp/day8:latest"
}