
data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

module "alb" {
  source = "../../ecs-alb"
  aws_region = "${var.aws_region}"
  instance_sg = "${var.instance_sg}"
  name_prefix = "${var.name}"
  vpc_id = "${data.aws_vpc.default.id}"
  subnets = "${var.subnets}"
  health_check = "${var.health_check}"
}

module "ecs_role" {
  source = "../../roles/ecs-role"
  name = "${var.name}"
}

module "ecs_alb_policy" {
  source = "../../policies/ecs-alb"
  name = "${var.name}-alb"
  role_name = "${module.ecs_role.name}"
}

data "aws_alb" "main" {
  arn = "${module.alb.arn}"
}

data "aws_alb_listener" "main" {
  arn = "${module.alb.listener_arn}"
}

data "aws_ecs_cluster" "main" {
  cluster_name = "${var.cluster_name}"
}

resource "aws_ecs_service" "main" {
  name            = "${var.name}"
  cluster         = "${data.aws_ecs_cluster.main.id}"
  task_definition = "${var.task_arn}"
  desired_count   = "${var.desired_task_count}"
  iam_role        = "${module.ecs_role.arn}"

  load_balancer {
    target_group_arn = "${module.alb.target_group_arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  depends_on = [
    "data.aws_ecs_cluster.main",
    "module.ecs_role",
    "module.ecs_alb_policy",
    "module.alb"
  ]
}

module "scaling" {
  source = "../../ecs-service-autoscale"
  cluster_name = "${var.cluster_name}"
  service_name = "${aws_ecs_service.main.name}"
  name_prefix = "${var.name}"
  max_task_count = "${var.max_task_count}"
  min_task_count = "${var.min_task_count}"
  dynamic_scaling = "${var.dynamic_scaling}"
}

