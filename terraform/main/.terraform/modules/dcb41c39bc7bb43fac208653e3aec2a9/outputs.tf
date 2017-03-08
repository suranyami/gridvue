output "dns_name" {
  value = "${aws_alb.main.dns_name}"
}

output "arn" {
  value = "${aws_alb.main.arn}"
}

output "listener_arn" {
  value = "${aws_alb_listener.main.arn}"
}

output "target_group_arn" {
  value = "${aws_alb_target_group.default.arn}"
}

output "security_group" {
  value = "${aws_security_group.alb.id}"
}
