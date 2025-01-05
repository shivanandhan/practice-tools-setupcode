resource "aws_iam_role" "role" {
  name = "${var.tool_name}-role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
  {
    "Effect": "Allow",
    "Principal": {
    "Service": "ec2.amazonaws.com"
  },
    "Action": "sts:AssumeRole"
  }
  ]
  }
 EOF

  tags = {
    Name = "${var.tool_name}-role"
  }
}