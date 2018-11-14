# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

module "EC2" {
  # The source field can be a path on your file system or a Git URL 
  vpc_id = "${aws_vpc.MyVPC.id}"
  source = "./modules"
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
#resource "aws_subnet" "public-subnet" {
 # vpc_id = "${aws_vpc.default.id}"
  #cidr_block = "${var.public_subnet_cidr}"
 # availability_zone = "us-east-1a"
 #
  #tags {
  #  Name = "Web Public Subnet"
  #}
#}
 
# Define the private subnet