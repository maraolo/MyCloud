output "pu1a_subnet_id" {
  value = "${aws_subnet.pusubnet1a.id}" 
}
output "pu1b_subnet_id" {
  value = "${aws_subnet.pusubnet1b.id}"
}

  output "pr1a_subnet_id" {
  value = "${aws_subnet.prsubnet1a.id}" 
}

output "security_groups_WS" {
    value = ["${aws_security_group.sgws.id}"] 
}
output "security_groups_DB" {
    value = ["${aws_security_group.sgdb.id}"] 
}