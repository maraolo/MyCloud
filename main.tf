# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
module "EC2" {
    source = "./modules"
    subnet_id = "${aws_subnet.psubnet.id}"
    cucu = "cucu"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "MyVPC" {
    cidr_block = "10.0.1.0/24"
    enable_dns_hostnames = true
    tags {
        Name = "Paolo-aws-vpc"
    }
}
# Define the public subnet
resource "aws_subnet" "psubnet" {
  vpc_id = "${aws_vpc.MyVPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
 
  tags {
   Name = "Web Public Subnet"
  }
}
 