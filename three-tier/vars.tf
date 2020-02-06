variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "pub_cidr" {
  type = list
  default = ["192.168.10.0/24","192.168.15.0/24"]
}
variable "web_cidr" {
  type = list
  default = ["192.168.20.0/24","192.168.25.0/24"]
}
variable "db_cidr" {
  type = list
  default = ["192.168.30.0/24","192.168.35.0/24"]
}
variable "web_number" {
}

variable "web_ami" {
}

variable "web_instance_type" {
}

variable "public_keypair_path" {
}

variable "db_password" {
}

variable "db_user" {
}
data "aws_availability_zones" "azs" {
  state = "available"
}
