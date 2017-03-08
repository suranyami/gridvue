resource "aws_ecs_cluster" "main" {
  name = "${var.name_prefix}-ecs"
}

module "ecs_role" {
  source = "../roles/ecs-role"
  name = "${var.name_prefix}_ecs_role"
}

module "ecs_alb" {
  source = "../policies/ecs-alb"
  name = "${var.name_prefix}_ecs_alb"
  role_name = "${module.ecs_role.name}"
}
