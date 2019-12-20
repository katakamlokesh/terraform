resource "aws_instance" "web" {
  ami = "ami-0c322300a1dd5dc79"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "HelloWorld"
  }
}
