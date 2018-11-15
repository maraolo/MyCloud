resource "aws_instance" "WebServer" {
  // ...
  ami = "${var.ami}"
  instance_type = "${var.In_Type}"
  # security_groups = ["${aws_security_group.MyWebDMZ.name}"]
  subnet_id = "${var.subnet_id}"
  # security_groups = ["${aws_security_group.example_rails_app.name}"]
  # user_data = "${data.template_file.user_data.rendered}"
  # key_name = "${var.key_pair_name}"
  
  tags {
    Name = "${var.cucu}"
    Department = "${var.Dep}"
    Team = "${var.Team}"
    EmployeeID = "${var.EmployeeID}"
  }
}

/* resource "aws_security_group" "MyWebDMZ" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.MyVPC.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    # prefix_list_ids = ["pl-12c4e678"]
  }
}*/