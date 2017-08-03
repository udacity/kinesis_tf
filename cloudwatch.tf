resource "aws_cloudwatch_log_group" "mod" {
  name = "${var.stream_name}"

  tags {
    Environment = "${var.environment_name}"
    Application = "${var.application_name}"
  }
}

resource "aws_cloudwatch_log_stream" "mod" {
  name           = "S3Delivery"
  log_group_name = "${aws_cloudwatch_log_group.mod.name}"
}
