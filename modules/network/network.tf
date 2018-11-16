# Create a VPC to launch our instances into
resource "aws_vpc" "MyVPC" {
    cidr_block = "10.0.1.0/24"
    enable_dns_hostnames = true
    tags {
        Name = "Paolo-aws-vpc"
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
  availability_zone = "eu-central-1b"
 
  tags {
   Name = "Private Subnet"
  }
} */