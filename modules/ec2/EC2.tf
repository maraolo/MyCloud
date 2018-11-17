resource "aws_instance" "WebServer" {
  ami = "${var.ami}"
  instance_type = "${var.In_Type}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_groups}"]
  # user_data = "${data.template_file.user_data.rendered}"
  # key_name = "${var.key_pair_name}"
  
  tags {
    Name = "${var.EC2name}"
    Department = "${var.Dep}"
    Team = "${var.Team}"
    EmployeeID = "${var.EmployeeID}"
  }
}