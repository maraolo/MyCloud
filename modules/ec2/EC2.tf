# Template for initial configuration bash script
data "template_file" "init" {
  template = "${file("bashscript.sh")}"

  vars {}
}
resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "${var.In_Type}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_groups}"]
  associate_public_ip_address = "true"
  user_data = "${data.template_file.init.rendered}"

  key_name = "${var.key_pair_name}"
  
  tags {
    Name = "${var.EC2name}"
  }
}