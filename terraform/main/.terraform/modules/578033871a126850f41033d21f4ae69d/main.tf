
resource "aws_autoscaling_policy" "scale_up" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  name = "${var.name_prefix}-asg-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_autoscaling_policy" "scale_down" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  name = "${var.name_prefix}-asg-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_max_threshold" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  alarm_name = "${var.name_prefix}-cpu_max_threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "${var.scale_up_threshold}"
  alarm_description = "Monitor cluster instance cpu utilization"
  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.scale_up.arn}"]
  depends_on = ["aws_autoscaling_policy.scale_up"]
}

resource "aws_cloudwatch_metric_alarm" "cpu_min_threshold" {
  count = "${var.dynamic_scaling == "true" ? 1 : 0}"
  alarm_name = "${var.name_prefix}-cpu_min_threshold"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "${var.scale_down_threshold}"
  alarm_description = "Monitor cluster instance cpu utilization"
  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
  alarm_actions = ["${aws_autoscaling_policy.scale_down.arn}"]
  depends_on = ["aws_autoscaling_policy.scale_down"]
}
