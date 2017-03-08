output "service_name" {
  value = "${aws_ecs_service.main.name}"
}

output "alb_arn" {
  value = "${data.aws_alb.main.arn}"
}
