- create my own VPC as follow:
    - 1 private subnet
    - 2 public subnets (in separate AZs) and in ACL apply it to them
    - IGW for accessing internet from public subnet
    - NAT GW for accessing internet from public subnet (installing middlewares)
    - 1 new Route Table with internet access using IGW and NAT GW only
    - 1 ACL only with rules => everything blocked (????)
    - 1 bastion host for admin access on EC2 instances on pr subnet
    - 1 security group for web server (MyWebDMZ) (still missing outbound rules)
    - 1 security group for DB server

- crete roles: EC2 accessing DB and S3
- create 1 Web Server EC2 instance in AZ1; 
- create 1 Web Server EC2 instance in AZ2
- create 1 DB Server EC2 instance
- create 1 ALB for the 2 web servers
- add user and roles for EC2
ToDos: 
    - apply ACL to pr Subnet also?
    - is ACL so correct (ports)?

http://www.blog.labouardy.com/manage-aws-vpc-as-infrastructure-as-code-with-terraform/
•	Roles per accedere altre risorse?
•	Userdata:
o	#!/bin/bash
o	yum update –y
o	yum install httpd –y
o	service httpd start
o	chkconfig httpd on
