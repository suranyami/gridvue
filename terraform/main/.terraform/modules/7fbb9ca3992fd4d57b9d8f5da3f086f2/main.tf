
resource "aws_iam_policy" "main" {
  name = "${var.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "allowLoggingToCloudWatch",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "${var.cloudwatch_logs_arn}"
      ]
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "main" {
  name = "${var.name}"
  policy_arn = "${aws_iam_policy.main.arn}"
  roles = ["${var.role}"]
  depends_on = ["aws_iam_policy.main"]
}