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