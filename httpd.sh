#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Hello world $(hostname)" > /var/www/root/html/index.html 