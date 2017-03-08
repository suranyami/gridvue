provider "aws" {
  region = "${var.aws_region}"
}

data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

module "ecs_cluster" {
  source        = "../ecs-cluster"
  aws_region        = "${var.aws_region}"
  name_prefix   = "${var.project_name}-ecs"
  instance_type = "${var.instance_type}"
  vpc_id        = "${var.vpc_id}"
  subnets       = "${var.subnets}"
  tags          = "${var.tags}"
}

module "instance_scaler" {
  source = "../ec2-cpu-autoscale"
  asg_name = "${module.ecs_cluster.asg_name}"
  name_prefix = "${var.project_name}"
  dynamic_scaling = "${var.dynamic_scaling}"
}

module "node_service" {
  source = "../ecs-services/simple-ecs-service"
  aws_region = "${var.aws_region}"
  cluster_name = "${module.ecs_cluster.cluster_name}"
  image_url = "${var.image_url}"
  instance_sg = "${module.ecs_cluster.sg_minion}"
  instance_role = "${module.ecs_cluster.iam_role_minion}"
  name = "${var.project_name}-node"
  subnets = "${var.subnets}"
  vpc_id = "${var.vpc_id}"
}

data "aws_alb" "main" {
  arn = "${module.node_service.alb_arn}"
}
