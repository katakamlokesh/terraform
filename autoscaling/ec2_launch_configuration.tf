resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example"
  image_id      = "ami-0bba96c31d87e65d9" 
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = ["subnet-027ab31fb0eb898c6"] 

  lifecycle {
    create_before_destroy = true
  }
}
