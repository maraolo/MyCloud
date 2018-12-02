#!/bin/bash
sudo su
yum install httpd -y
yum update -y
cd /var/www/html
echo "Web Server Paolo" > index.html
service httpd start
chkconfig httpd on
