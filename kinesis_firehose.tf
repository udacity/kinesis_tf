resource "aws_s3_bucket" "mod" {
  bucket = "udacity-${var.stream_name}-event-backup"
  acl    = "private"
}

resource "aws_kinesis_firehose_delivery_stream" "mod" {
  name        = "${var.stream_name}-backup"
  destination = "s3"

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.mod.arn}"

    cloudwatch_logging_options {
      enabled         = "true"
      log_group_name  = "${aws_cloudwatch_log_group.mod.name}"
      log_stream_name = "${aws_cloudwatch_log_stream.mod.name}"
    }
  }
}
