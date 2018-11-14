variable "EC2Name" {
  description = "The name of the EC2 instance"
  default = "Web Server"
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
variable "EmployeeID" {
  description = "ID"
  default = "868675764"
}
variable "SGID" {
  description = "SGID"
  default = "sg-0788fc00b00093cf1"
}
variable "vpc_id" {
  description = "VPC ID"
}