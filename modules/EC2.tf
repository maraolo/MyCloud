resource "aws_instance" "EC2Instance" {
  // ...
  ami = "${var.ami}"
  instance_type = "${var.In_Type}"
  #vpc_id = "${var.vpc_id}"
  # security_groups = ["${aws_security_group.example_rails_app.name}"]
  # user_data = "${data.template_file.user_data.rendered}"
  # key_name = "${var.key_pair_name}"
  
  tags {
    Name = "${var.EC2Name}"
    Department = "${var.Dep}"
    Team = "${var.Team}"
    EmployeeID = "${var.EmployeeID}"
  }
   security_groups = ["${var.SGID}"]
}