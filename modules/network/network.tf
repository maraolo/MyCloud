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
  subnet_ids = ["${aws_subnet.pusubnet1a.id}","${aws_subnet.pusubnet1b.id}"]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
   ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

   ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
 egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
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
# Define the eip to be used for NAT GW
resource "aws_eip" "eip4NAT" {
  vpc = true
}
#define NAT GW in public Subnet 1a
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.eip4NAT.id}"
  subnet_id = "${aws_subnet.pusubnet1a.id}"

  tags {
    Name = "NatGW"
  }
}
# Define the route table with public access
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.MyVPC.id}"
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
 
  tags {
    Name = "Public Subnet RT"
  }
}
# Define the route table with private access only
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.MyVPC.id}"
 
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }
 
  tags {
    Name = "private Subnet RT"
  }
}
# Assign the route table to the public Subnet 1a
resource "aws_route_table_association" "web-public1a-rt-ass" {
  subnet_id = "${aws_subnet.pusubnet1a.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet 1b
resource "aws_route_table_association" "web-public1b-rt-ass1" {
  subnet_id = "${aws_subnet.pusubnet1b.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the private Subnet 1a
resource "aws_route_table_association" "web-private1a-rt-ass1" {
  subnet_id = "${aws_subnet.prsubnet1a.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

# Create the public subnet in 1a
 resource "aws_subnet" "pusubnet1a" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  
  tags {
   Name = "Public Subnet 1"
  }
}

# Create the public subnet in 1b
 resource "aws_subnet" "pusubnet1b" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags {
   Name = "Public Subnet 2"
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
  name = "webServerSG"
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
  name = "DBServerSG"
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
    Name = "SG for DB Server"
  }
}