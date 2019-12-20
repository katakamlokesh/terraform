provider "aws" {
  region = "us-east-1"
}

variable "env" {
  default = "prod"
}

resource "aws_vpc" "main" {
  count = var.env == "prod" ? 1:0
  cidr_block = "13.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "main-2"
    AppName = "MyApp"
  }
}

