output "subnet_id" {
  value = "${aws_subnet.pusubnet.id}" 
}

output "security_groups" {
    value = ["${aws_security_group.sgws.id}"] 
}