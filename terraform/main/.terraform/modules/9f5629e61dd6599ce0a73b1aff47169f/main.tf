
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "${var.cluster_name}"
}

resource "aws_appautoscaling_target" "app" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  max_capacity = "${var.max_task_count}"
  min_capacity = "${var.min_task_count}"
  resource_id = "service/${var.cluster_name}/${var.service_name}"
  role_arn = "${aws_iam_role.ecs_auto_scaling.arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  metric_aggregation_type = "Average"
  name = "${var.name_prefix}-task-up"
  resource_id = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment = 1
  }

  depends_on = [
    "data.aws_ecs_cluster.ecs_cluster",
    "aws_appautoscaling_target.app",
    "aws_iam_role_policy_attachment.ecs_auto_scaling"
  ]
}


resource "aws_appautoscaling_policy" "scale_down" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  metric_aggregation_type = "Average"
  name = "${var.name_prefix}-task-down"
  resource_id = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment = -1
  }

  depends_on = [
    "data.aws_ecs_cluster.ecs_cluster",
    "aws_appautoscaling_target.app",
    "aws_iam_role_policy_attachment.ecs_auto_scaling"
  ]
}


resource "aws_cloudwatch_metric_alarm" "cpu_max_threshold" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  alarm_name = "${var.name_prefix}-task-max-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = "60"
  statistic = "Average"
  threshold = "${var.scale_up_threshold}"
  alarm_description = "Monitor task max cpu utilization"
  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
  alarm_actions = ["${aws_appautoscaling_policy.scale_up.arn}"]
  depends_on = ["aws_iam_role.ecs_auto_scaling", "aws_iam_role_policy_attachment.ecs_auto_scaling"]
}


resource "aws_cloudwatch_metric_alarm" "cpu_min_threshold" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  alarm_name = "${var.name_prefix}-task-min-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = "60"
  statistic = "Average"
  threshold = "${var.scale_down_threshold}"
  alarm_description = "Monitor task min cpu utilization"
  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
  alarm_actions = ["${aws_appautoscaling_policy.scale_down.arn}"]
  depends_on = ["aws_iam_role.ecs_auto_scaling", "aws_iam_role_policy_attachment.ecs_auto_scaling"]
}


resource "aws_iam_role" "ecs_auto_scaling" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  name = "${var.name_prefix}-task-auto-scale-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_auto_scaling" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  role = "${aws_iam_role.ecs_auto_scaling.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
  depends_on = ["aws_iam_role.ecs_auto_scaling"]
}
