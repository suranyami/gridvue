
data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name}/main"
}

module "logging_policy" {
  source = "../../policies/cloudwatch-logging"
  cloudwatch_logs_arn = "${aws_cloudwatch_log_group.main.arn}"
  role = "${var.instance_role}"
  name = "${var.name}-task-logging"
}

module "task" {
  source = "../../ecs-tasks/generic-docker-task"
  cloudwatch_log_group = "${aws_cloudwatch_log_group.main.name}"
  cloudwatch_log_region = "${var.aws_region}"
  image_url = "${var.image_url}"
  name = "${var.name}-task"
  environment_variables = "${var.environment_variables}"
  memory_reservation = "${var.memory_reservation}"
  task_role_arn = "${var.task_role_arn}"
}

module "ecs_service" {
  source = "../service-with-alb"
  aws_region = "${var.aws_region}"
  cluster_name = "${var.cluster_name}"
  container_name = "${module.task.container_name}"
  container_port = "${var.container_port}"
  instance_sg = "${var.instance_sg}"
  name = "${var.name}"
  subnets = "${var.subnets}"
  task_arn = "${module.task.arn}"
  vpc_id = "${data.aws_vpc.default.id}"
}