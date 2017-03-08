output "arn" {
  value = "${aws_ecs_task_definition.main.arn}"
}

output "name" {
  value = "${aws_ecs_task_definition.main.}"
}

output "container_name" {
  value = "${data.template_file.app_task.vars.container_name}"
}
