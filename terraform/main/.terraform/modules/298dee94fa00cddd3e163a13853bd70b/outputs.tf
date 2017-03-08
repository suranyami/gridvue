output "service_name" {
  value = "${module.ecs_service.service_name}"
}

output "alb_arn" {
  value = "${module.ecs_service.alb_arn}"
}
