# Create a VPC to launch our instances into
resource "aws_vpc" "MyVPC" {
    cidr_block = "10.0.1.0/24"
    enable_dns_hostnames = true
    tags {
        Name = "Paolo-vpc"
    }
}
# Create the public subnet
 resource "aws_subnet" "pusubnet" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
 
  tags {
   Name = "Public Subnet"
  }
}

/* # Create the private subnet
 resource "aws_subnet" "prsubnet" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
 
  tags {
   Name = "Private Subnet"
  }
} */

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