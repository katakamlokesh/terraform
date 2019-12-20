variable "region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "160.0.0.0/16"
}
variable "subnet_cidr" {
  type = list
  default = ["160.0.0.0/24","160.0.1.0/24","160.0.2.0/24","160.0.3.0/24","160.0.4.0/24","160.0.5.0/24"]
}
#variable "azs" {
#  type = list
# default = ["us-east-1a","us-east-1b","us-east-1c"]
 #}
data "aws_availability_zones" "azs" {}

