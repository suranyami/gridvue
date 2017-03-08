### Security

resource "aws_security_group" "minion" {
  description = "controls direct access to application instances"
  vpc_id      = "${data.aws_vpc.main.id}"
  name        = "${var.name_prefix}-minion"
  tags {
    Terraform = "true"
    Realm = "${lookup(var.tags, "realm", "")}"
    Environment = "${lookup(var.tags, "environment", "")}"
    Stack = "${lookup(var.tags, "stack", "")}"
    Application = "${lookup(var.tags, "application", "")}"
  }
}

resource "aws_security_group_rule" "minion_egress" {
  type = "egress"
  security_group_id = "${aws_security_group.minion.id}"
  protocol  = "tcp"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
