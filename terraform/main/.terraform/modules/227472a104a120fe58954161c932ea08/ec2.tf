resource "aws_autoscaling_group" "minion" {
  name                 = "${var.name_prefix}-asg"
  vpc_zone_identifier  = ["${var.subnets}"]
  min_size             = "${var.min_instance_count}"
  max_size             = "${var.max_instance_count}"
  desired_capacity     = "${var.desired_instance_count}"
  launch_configuration = "${aws_launch_configuration.minion.name}"

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-minion"
    propagate_at_launch = true
  }
  tag {
    key = "Terraform"
    value = "true"
    propagate_at_launch = true
  }

  tag {
    key = "Realm"
    value = "${lookup(var.tags, "realm", "")}"
    propagate_at_launch = true
  }

  tag {
    key = "Environment"
    value = "${lookup(var.tags, "environment", "")}"
    propagate_at_launch = true
  }
  tag {
    key = "Stack"
    value = "${lookup(var.tags, "stack", "")}"
    propagate_at_launch = true
  }
  tag {
    key = "Application"
    value = "${lookup(var.tags, "application", "")}"
    propagate_at_launch = true
  }


  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances"]
}

data "template_file" "minion_cloud_config" {
  template = "${file("${path.module}/minion-cloud-config.yml")}"

  vars {
    aws_region         = "${var.aws_region}"
    ecs_cluster_name   = "${aws_ecs_cluster.main.name}"
    ecs_log_level      = "info"
    ecs_agent_version  = "latest"
    ecs_log_group_name = "${aws_cloudwatch_log_group.ecs.name}"
    file_systems       = ""
  }
}

resource "aws_launch_configuration" "minion" {
  security_groups = [
    "${aws_security_group.minion.id}",
  ]

  name_prefix = "${var.name_prefix}-"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.minion.name}"
  image_id = "${data.aws_ami.ecs_optimized.id}"
  user_data = "${data.template_file.minion_cloud_config.rendered}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "minion" {
  name = "${var.name_prefix}-minion-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "minion" {
  name  = "${var.name_prefix}-minion-profile"
  roles = ["${aws_iam_role.minion.name}"]
}


data "template_file" "instance_profile" {
  template = "${file("${path.module}/instance-profile-policy.json")}"

  vars {
    app_log_group_arn = "${aws_cloudwatch_log_group.app.arn}"
    ecs_log_group_arn = "${aws_cloudwatch_log_group.ecs.arn}"
  }
}

resource "aws_iam_role_policy" "instance" {
  name   = "${var.name_prefix}-minion-policy"
  role   = "${aws_iam_role.minion.name}"
  policy = "${data.template_file.instance_profile.rendered}"
}
