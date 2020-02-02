variable "aws_region" {
  description = "Enter AWS region to launch servers."
}
variable "vpc_cidr" {
  default = "10.20.0.0/16"
}
variable "subnet_cidr" {
  type = list
  default = ["10.20.1.0/24","10.20.2.0/24"]
}
data "aws_availability_zones" "azs" {
}
variable "azs" {
  type = list
  default = ["us-east-1a","us-east-1b"]
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-04b9e92b5572fa0d1"
    us-east-2 = "ami-0d5d9d301c853a04a"
    us-west-1 = "ami-0dd655843c87b6930"
    us-west-2 = "ami-06d51e91cea0dac8d"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
