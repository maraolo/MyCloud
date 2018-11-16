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
variable "EmployeeID" {
  description = "ID"
  default = "868675764"
}

variable "subnet_id" {
  description = "SN ID"
}