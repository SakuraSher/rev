data aws_region current {}
resource "aws_vpc" "vpc"{
    cidr_block = "10.0.0.0/16"
    tags ={
        Name = "terraform-vpc"
    }
    
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id
    tags ={

        Name = "terraform-igw"
    }

}

resource "aws_eip" "eip"{
    domain = "vpc"
     tags ={

        Name = "terraform-eip"
    }

}

resource "aws_nat_gateway" "nat"{
    subnet_id = aws_subnet.public_subnet1.id
    allocation_id = aws_eip.eip.id
    depends_on = [aws_internet_gateway.igw]
     tags ={

        Name = "terraform-nat"
    }

}
resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.vpc.id
    tags ={
        cost-center = "01234567890"
         Name = "public-rt"
    }
}


resource "aws_route" "public_rt_route"{
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

    
    
}

resource "aws_route_table_association" "public_rt_assoc"{
    route_table_id = aws_route_table.public_rt.id
    for_each = toset([aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id])
    
    subnet_id = each.value
}

resource "aws_subnet" "public_subnet1"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet1_cidr
    tags ={
         Name = "public-subnet1"
    }
   

}



resource "aws_subnet" "public_subnet2"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet2_cidr
   tags ={
         name = "public-subnet2"
    }
}


# resource "aws_route_association" "public_rt_assoc"{
#     route_table_id = aws_route_table.public_rt.id
#     subnet_id = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
# }

resource "aws_subnet" "private_subnet3"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet3_cidr
   

}


resource "aws_subnet" "private_subnet4"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet4_cidr
   

}

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.vpc.id
    tags ={
         Name = "private-rt"
    }


}

resource "aws_route_table_association" "private_rt_assoc1"{
    route_table_id = aws_route_table.private_rt.id
    for_each = toset([aws_subnet.private_subnet3.id, aws_subnet.private_subnet4.id])
    subnet_id = each.value

}

resource "aws_route" "private_rt_route"{
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
}