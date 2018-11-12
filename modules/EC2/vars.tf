variable "EC2name" {
  description = "The name of the EC2 instance"
  default = ""
}
variable "ami" {
  description = "The ID of the AMI that has Ruby on Rails installed and contains the code from the example-rails-app"
  default = "ami-0233214e13e500f77"
}