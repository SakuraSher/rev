variable "vpc_name"{
    type = string
    description = "The name of the VPC"
}
variable "environment"{
    description = "The environment for the network module"
    type = string
}

variable "project_id"{
    type = string
    description = "The project ID where the network resources will be created"
}

variable "vpc_cidr"{
    type = string
    description = "The CIDR block for the VPC"
}

variable "private_subnet"{
    type = list(object({
       cidr_block = string
       availability_zone = string
       prefix = string 
    }))
}


variable "public_subnet"{
    type = list(object({
       cidr_block = string
       availability_zone = string
       prefix = string 
    }))
}

variable "need_nat_gateway"{
    type = bool
    description = "Boolean to determine if a NAT Gateway is needed"
    default = false
}

variable "need_only_one_nat_gateway"{
    type = bool
    description = "Boolean to determine if only one NAT Gateway is needed"
    default = false
}


variable "enable_dns_support"{
    type = bool
    description = "Boolean to determine if DNS support is enabled for the VPC"
    default = true
}

variable "enable_dns_hostnames"{
    type = bool
    description = "Boolean to determine if DNS hostnames are enabled for the VPC"
    default = true
}

variable "default_tags" {
    type = map(string)
    description = "A map of default tags to apply to all resources"
    default = {}
}

variable "aws_region" {
    type = string
    description = "The AWS region where the resources will be created"
}