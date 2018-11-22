# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
module "network" {
    source = "./modules/network"
}
module "WS1" {
    source = "./modules/ec2"
    subnet_id = "${module.network.pu1a_subnet_id}"
    security_groups = ["${module.network.security_groups_WS}"]
    # security_groups = ["${module.network.security_groups}"]
    EC2name = "Web Server 1"
}

module "WS2" {
    source = "./modules/ec2"
    subnet_id = "${module.network.pu1b_subnet_id}"
    security_groups = ["${module.network.security_groups_WS}"]
    # security_groups = ["${module.network.security_groups}"]
    EC2name = "Web Server 2"
}

module "DBS" {
    source = "./modules/ec2"
    subnet_id = "${module.network.pr1a_subnet_id}"
    security_groups = ["${module.network.security_groups_DB}"]
    # security_groups = ["${module.network.security_groups}"]
    EC2name = "DB Server"
}