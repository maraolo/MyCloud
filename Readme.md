- create my own VPC as follow:
    - 1 private subnet
    - 2 public subnets (in separate AZs) and in ACL apply it to them
    - IGW for accessing internet from public subnet
    - create an elstic IP for NAT GW
    - NAT GW for accessing internet from public subnet (installing middlewares)
    - 2 Route Tables: 1 with internet access using IGW and 1 with NAT GW only for public subnet (Each subnet must be associated with a route table, which controls the routing for the subnet)
    - 1 ACL only with rules => everything blocked (ephemeral ports?)
    - 1 bastion host for admin access on EC2 instances on pr subnet
    - 1 security group for web server (still missing outbound rules)
    - 1 security group for DB server

- create 1 Web Server EC2 instance in AZ1 (publi ip)
- create 1 Web Server EC2 instance in AZ2 (public ip)
- create 1 DB Instance MySQL
-   I have to configure the DB-SG for incoming port (3306) giving not IP-ranges of Web Servers, but SG directly where they sit (lezione 68)
- create 1 ALB for the 2 web servers
- add user and roles for EC2
ToDos: 
    - apply ACL to pr Subnet also?
    - is ACL so correct (ports)?
    - outboud rules for SGs 

http://www.blog.labouardy.com/manage-aws-vpc-as-infrastructure-as-code-with-terraform/
•	Roles per accedere altre risorse?

For RDB
#!/bin/bash  
yum install httpd php php-mysql -y  
yum update -y  
chkconfig httpd on  
service httpd start  
echo "<?php phpinfo();?>" > /var/www/html/index.php
cd /var/www/html  
wget https://s3.amazonaws.com/acloudguru-production/connect.php

oppure: aws s3 cp s3://YOURBUCKETNAMEHERE/index.html /var/www/html/

questo é il codice su S3
<?php 
$username = "acloudguru"; 
$password = "acloudguru"; 
$hostname = "yourhostnameaddress"; 
$dbname = "acloudguru";

//connection to the database
$dbhandle = mysql_connect($hostname, $username, $password) or die("Unable to connect to MySQL"); 
echo "Connected to MySQL using username - $username, password - $password, host - $hostname<br>"; 
$selected = mysql_select_db("$dbname",$dbhandle)   or die("Unable to connect to MySQL DB - check the database name and try again."); 
?>

aggiornare hostname con ID di EC2 2 db-Endpoint concatenati
