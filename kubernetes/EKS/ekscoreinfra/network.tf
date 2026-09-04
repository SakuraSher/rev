module "vpc"{
    source = "terraform-aws-modules/vpc/aws"
    name = "${var.environment}-${var.vpc_name}"
    cidr = var.vpc_cidr
    
    public_subnets = [var.public_subnet[0], var.public_subnet[1]]
    private_subnets = [var.private_subnet[0],var.private_subnet[1]]

    azs = ["ap-south-1a", "ap-south-1b"]
    enable_nat_gateway = true
    single_nat_gateway = true
    enable_vpn_gateway = true

    enable_dns_hostnames = true
    enable_dns_support = true


}