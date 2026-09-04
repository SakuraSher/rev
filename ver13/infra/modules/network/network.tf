resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = {
        Name = var.vpc_name
    }

    }

    resource "aws_subnet" "private_subnet" {
        for_each = { for idx, subnet in var.private_subnet : idx => subnet}
        vpc_id = aws_vpc.vpc.id
        cidr_block = each.value.cidr_block
        availability_zone = each.value.availability_zone
        tags = {
            Name = "${var.vpc_name}-private-${each.value.prefix}"}

    }

    resource "aws_subnet" "public_subnet"{
        for_each = { for idx, subnet in var.public_subnet : idx  => subnet}
        vpc_id = aws_vpc.vpc.id
        cidr_block = each.value.cidr_block
        availability_zone = each.value.availability_zone
        tags = {
            Name = "${var.vpc_name}-public-${each.value.prefix}"

        }

    }

    resource "aws_internet_gateway" "igw"{
        vpc_id = aws_vpc.vpc.id
        tags = {
            Name = "${var.vpc_name}-igw"
        }
    }

    resource "aws_eip" "eip" {
        count = var.need_nat_gateway ? var.need_only_one_nat_gateway?1: len(var.public_subnet):0

    }

    resource "aws_nat_gateway" "nat_gateway"{
         count = var.need_nat_gateway ? var.need_only_one_nat_gateway?1: len(var.public_subnet):0
         allocation_id = aws_eip.eip[count.index]
         subnet_id = aws_subnet.public_subnet[count.index]
         tags = {
            Name = "${var.vpc_name}-nat-${count.index}"
         }
         
    }

    resource "aws_route_table" "public_rt"{
        vpc_id = aws_vpc.vpc.id
        tags = {
            Name = "${var.vpc_name}-public-rt"
        }
        
    }

    resource "aws_route" "public_route" {
        route_table_id = aws_route_table.public_rt
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id

    }

    resource "aws_route_table_association" "public_rt_assoc"{
        count = length(var.public_subnet)
        subnet_id = aws_subnet.public_subnet[count.index].id
        route_table_id =  aws_route_table.public_rt.id
    }