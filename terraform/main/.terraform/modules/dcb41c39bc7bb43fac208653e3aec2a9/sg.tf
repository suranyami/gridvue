
resource "aws_security_group" "alb" {
  description = "controls access to the application LB"

  vpc_id = "${data.aws_vpc.main.id}"
  name   = "${var.name_prefix}"
  tags {
    Terraform = "true"
    Realm = "${lookup(var.tags, "realm", "")}"
    Environment = "${lookup(var.tags, "environment", "")}"
    Stack = "${lookup(var.tags, "stack", "")}"
    Application = "${lookup(var.tags, "application", "")}"
  }
}

resource "aws_security_group_rule" "alb_http_ingress" {
  type = "ingress"
  security_group_id = "${aws_security_group.alb.id}"
  protocol    = "tcp"
  from_port   = "${var.port}"
  to_port     = "${var.port}"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress" {
  type = "egress"
  security_group_id = "${aws_security_group.alb.id}"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "minion_alb_ingress_0" {
  type = "ingress"
  security_group_id = "${data.aws_security_group.ec2.id}"
  protocol  = "tcp"
  from_port = 1024
  to_port   = 2374
  source_security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_security_group_rule" "minion_alb_ingress_1" {
  type = "ingress"
  security_group_id = "${data.aws_security_group.ec2.id}"
  protocol  = "tcp"
  from_port = 2377
  to_port   = 51677
  source_security_group_id = "${aws_security_group.alb.id}"
}

resource "aws_security_group_rule" "minion_alb_ingress_2" {
  type = "ingress"
  security_group_id = "${data.aws_security_group.ec2.id}"
  protocol  = "tcp"
  from_port = 51680
  to_port   = 65535

  source_security_group_id = "${aws_security_group.alb.id}"
}
