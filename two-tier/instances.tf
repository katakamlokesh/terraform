resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web" {
  connection {
    # The default username for our AMI
    user = "ubuntu"
    host = self.public_ip
    # The connection will use the local SSH agent for authentication.
  }
  count = length(var.subnet_cidr)
  ami = lookup(var.aws_amis, var.aws_region)
  instance_type = var.instance_type
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.webservers.id] 
  subnet_id = element(aws_subnet.Public.*.id,count.index)
  user_data = file("install_httpd.sh")
  
  tags = {
    Name = "Server-${count.index}"
  }
}
