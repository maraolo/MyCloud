# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

module "EC2" {
  # The source field can be a path on your file system or a Git URL 
  source = "./modules/EC2"
}