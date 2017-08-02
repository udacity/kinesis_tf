resource "aws_kinesis_stream" "mod" {
  name             = "${var.stream_name}"
  shard_count      = "${var.shard_count}"
  retention_period = "${var.retention_period}"

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags {
    ForwardToFirehoseStream = "${aws_s3_bucket.bucket.bucket}"
  }
}
