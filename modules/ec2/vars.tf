variable "EC2name" {
  description = "The name of the EC2 instance"
  default = ""
}
variable "ami" {
  description = "The ID of the AMI"
  default = "ami-0233214e13e500f77"
}
variable "In_Type" {
  description = "The type of the EC2 instance"
  default = "t2.micro"
}
variable "Dep" {
  description = "The DEp"
  default = "Developers"
}
variable "Team" {
  description = "The Team"
  default = "RandD"
}
variable "subnet_id" {
  description = "SN ID"
}  
variable security_groups {
    description = "Sec Group Ids"
    type = "list"
}
variable key_pair_name {
  description = "Keypair"
  default = "maKEyTutorial"
} 

/* data "template_file" "user_data" {
  template = "${file("${path.module}/bashscript.sh")}"
  vars {
    name = "${var.name}"
  }
}

resource "aws_instance" "nat" {
 # ...
 user_data = "${data.template_file.user_data.rendered}"
}*/