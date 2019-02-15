resource "aws_cloudwatch_log_group" "mod" {
  name  = "${var.stream_name}"
  count = "${var.create_s3_backup}"

  tags {
    Environment = "${var.environment_name}"
    Application = "${var.application_name}"
  }
}

resource "aws_cloudwatch_log_stream" "mod" {
  name  = "S3Delivery"
  count = "${var.create_s3_backup}"

  log_group_name = "${aws_cloudwatch_log_group.mod.name}"
}
