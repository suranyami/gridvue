
data "template_file" "app_task" {
  template = "${file("${path.module}/task-definition.json.template")}"

  vars {
    image_url = "${var.image_url}"
    container_name = "${var.container_name}"
    container_port = "${var.container_port}"
    log_group_region = "${var.cloudwatch_log_region}"
    log_group_name = "${var.cloudwatch_log_group}"
    memory_reservation = "${var.memory_reservation}"
    environment = "${join(",", formatlist("{\"name\":\"%s\", \"value\":\"%s\"}", keys(merge(map("PORT", var.container_port), var.environment_variables)), values(merge(map("PORT", var.container_port), var.environment_variables))))}"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = "${var.name}"
  container_definitions = "${data.template_file.app_task.rendered}"
  task_role_arn         = "${var.task_role_arn}"
}
