
output "launch_configuration" {
  value = "${aws_launch_configuration.minion.id}"
}

output "asg" {
  value = "${aws_autoscaling_group.minion.id}"
}


output "asg_name" {
  value = "${aws_autoscaling_group.minion.name}"
}

output "cloudwatch_log_group" {
  value = "${aws_cloudwatch_log_group.app.name}"
}

output "cluster_id" {
  value = "${aws_ecs_cluster.main.id}"
}

output "cluster_name" {
  value = "${aws_ecs_cluster.main.name}"
}

output "iam_role_ecs" {
  value = "${module.ecs_role.id}"
}

output "iam_role_ecs_arn" {
  value = "${module.ecs_role.arn}"
}

output "iam_role_minion" {
  value = "${aws_iam_role.minion.name}"
}

output "sg_minion" {
  value = "${aws_security_group.minion.id}"
}
