
#Provision vpc, subnets, igw, and default route-table
#1 VPC - 5 subnets (public, 2web, 2database)

#provision app vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "WP Solution VPC"
  }
}

# create igw
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app_igw"
  }
}

# add dhcp options
resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["8.8.8.8", "8.8.4.4"]
}

# associate dhcp with vpc
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

#provision public subnet
resource "aws_subnet" "pub_subnet" {
  count = var.web_number
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.pub_cidr,count.index)
  tags = {
    Name = "public subnet-${count.index+1}"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolver]
}
#provision webserver subnet
resource "aws_subnet" "web_subnet" {
  count = var.web_number
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.web_cidr,count.index)
  tags = {
    Name = "web server subnet-${count.index+1}"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolver]
}

#provision database subnet
resource "aws_subnet" "db_subnet" {
  count = var.web_number
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.db_cidr,count.index)
  tags = {
    Name = "database subnet-${count.index+1}"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolver]
}

#default route table 
resource "aws_default_route_table" "default" {
  default_route_table_id =  aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
  
}


