# Create a VPC to launch our instances into
resource "aws_vpc" "MyVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags {
        Name = "VPC4Paolo"
    }
}

# Create the ACL for VPC
resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  subnet_ids = ["${aws_subnet.pusubnet1a.id}","${aws_subnet.pusubnet1b.id} "]

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

   /* ingress {
    protocol   = "ssh"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }*/

  tags {
    Name = "main ACL Paolo"
  }
}
# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.MyVPC.id}"

  tags {
    Name = "mainIGW"
  }
}
# Create the public subnet in 1a
 resource "aws_subnet" "pusubnet1a" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  
 
  tags {
   Name = "Public Subnet"
  }
}

# Create the public subnet in 1b
 resource "aws_subnet" "pusubnet1b" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

 
  tags {
   Name = "Public Subnet"
  }
}
# Create the private subnet
 resource "aws_subnet" "prsubnet1a" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-central-1a"
 
  tags {
   Name = "Private Subnet"
  }
} 

# Define the security group for WebServer instance
resource "aws_security_group" "sgws" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections and SSH access"
  vpc_id = "${aws_vpc.MyVPC.id}"
 
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  /* ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/ 
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

   tags {
    Name = "SG for Web Server"
  }
}
resource "aws_security_group" "sgdb" {
  name = "vpc_test_web"
  description = "Allow incoming MySQL/Aurora connections and SSH access"
  vpc_id = "${aws_vpc.MyVPC.id}"
 
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }
 
  /* ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/ 
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

   tags {
    Name = "SG for Web Server"
  }
}