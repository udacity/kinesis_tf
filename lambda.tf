resource "aws_lambda_function" "copy_to_firehose" {
  s3_bucket        = "lambda-package-cache"
  s3_key           = "LambdaStreamToFirehose-1.4.5.zip"
  function_name    = "LambdaStreamToFirehose"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "YzAxOTJlNWVkYjAyNjJjMDNjOWZmNmM3Y2VhZDdiYmYyZjVjNmI1ZTdhMjRkYTIxOWRmMGEwY2Y3NDhjNmJjNgo="
  runtime          = "nodejs4.3"

  environment {
    variables = {
      USE_DEFAULT_DELIVERY_STREAMS = "false"
    }
  }
}

resource "aws_lambda_event_source_mapping" "stream_event_source" {
  batch_size        = 100
  event_source_arn  = "${aws_kinesis_stream.mod.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.copy_to_firehose.arn}"
  starting_position = "TRIM_HORIZON"
}
