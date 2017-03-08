data "aws_vpc" "main" {
  id = "${var.vpc_id}"
}

data "aws_security_group" "ec2" {
  id = "${var.instance_sg}"
}

resource "aws_alb_target_group" "default" {
  name     = "${var.name_prefix}-default"
  port     = "${var.port}"
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.main.id}"
  tags {
    Terraform = "true"
    Realm = "${lookup(var.tags, "realm", "")}"
    Environment = "${lookup(var.tags, "environment", "")}"
    Stack = "${lookup(var.tags, "stack", "")}"
    Application = "${lookup(var.tags, "application", "")}"
  }

  health_check {
    interval = "${lookup(var.health_check, "interval", 10)}"
    timeout = "${lookup(var.health_check, "timeout", 5)}"
    path = "${lookup(var.health_check, "path", "/")}"
  }
}

resource "aws_alb" "main" {
  name            = "${var.name_prefix}"
  subnets         = ["${var.subnets}"]
  security_groups = ["${aws_security_group.alb.id}"]
  internal = "${var.internal == "true"}"
  tags {
    Terraform = "true"
    Realm = "${lookup(var.tags, "realm", "")}"
    Environment = "${lookup(var.tags, "environment", "")}"
    Stack = "${lookup(var.tags, "stack", "")}"
    Application = "${lookup(var.tags, "application", "")}"
  }
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "${var.port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.default.arn}"
    type             = "forward"
  }
}