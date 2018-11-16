# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
module "network" {
    source = "./modules/network"
}
module "EC2" {
    source = "./modules/ec2"
    subnet_id = "${module.network.subnet_id}"
    # subnet_id = ${aws_subnet.pusubnet.subnet_id}"
    EC2name = "Web Server"
}