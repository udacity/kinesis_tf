resource "aws_lambda_function" "mod" {
  s3_bucket     = "lambda-package-cache"
  s3_key        = "LambdaStreamToFirehose-1.4.5.zip"
  function_name = "${var.stream_name}-LambdaStreamToFirehose"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "index.handler"
  runtime       = "nodejs4.3"

  environment {
    variables = {
      USE_DEFAULT_DELIVERY_STREAMS = "false"
    }
  }
}

resource "aws_lambda_event_source_mapping" "mod" {
  batch_size        = 100
  event_source_arn  = "${aws_kinesis_stream.mod.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.mod.arn}"
  starting_position = "TRIM_HORIZON"
}
