provider "aws" {
  region = var.aws_region
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "ELB_VPC"
  }
}

resource "aws_internet_gateway" "elb_igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Elb_IGW"
  }
}

#Build subnets for vpc
resource "aws_subnet" "Public" {
  count = length(var.subnet_cidr)
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  vpc_id = aws_vpc.main.id 
  cidr_block = element(var.subnet_cidr,count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "ELb_subent+${count.index+1}"	
  }  
}

# Create Route Table ,attach InternetGateway and Associate With Public subnets

resource "aws_route_table" "Public_rt" {
  vpc_id = aws_vpc.main.id
  
  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.elb_igw.id
  }
  tags = {
    Name = "Public_rt"
  }
}

# Attach Route Table to Public Subnets

resource "aws_route_table_association" "a" {
  count = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.Public.*.id, count.index)
  route_table_id = aws_route_table.Public_rt.id
}
