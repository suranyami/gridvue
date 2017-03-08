provider "aws" {
  region = "${var.aws_region}"
}

module "node_app" {
  source = "../simple-node-app"
  aws_region = "${var.aws_region}"
  image_url = "${var.image_url}"
  vpc_id = "${var.vpc_id}"
  subnets = "${var.subnets}"
  desired_task_count = "${var.desired_task_count}"
  max_task_count = "${var.max_task_count}"
  min_task_count = "${var.min_task_count}"
  project_name = "${var.project_name}"
  tags = "${var.tags}"
}

output "elb_hostname" {
  value = "${module.node_app.elb_hostname}"
}
