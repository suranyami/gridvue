
## CloudWatch Logs

resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.name_prefix}-log-group/ecs"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "${var.name_prefix}-log-group/app"
}
