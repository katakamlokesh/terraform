provider "aws" {
  region  = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "katakam-04"
    key    = "myapp/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
