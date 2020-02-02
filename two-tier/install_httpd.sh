#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
echo "<h1> Deployment Through ELB using Terraform </h1>" > /var/www/html/index.html
systemctl restart apache2
systemctl status apache2

