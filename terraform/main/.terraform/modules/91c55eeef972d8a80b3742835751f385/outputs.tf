
output "elb_hostname" {
  value = "${data.aws_alb.main.dns_name}"
}
