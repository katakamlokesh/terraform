resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = "Main"
 }
}
resource "aws_subnet" "subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr

  tags =  { 
    Name = "main"
 }
}
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "subnet_id" {
  value = "${aws_subnet.subnet.id}"
}
