resource "aws_api_gateway_rest_api" "mod" {
  count       = "${var.create_api_gateway}"
  name        = "${var.stream_name}-api"
  description = "Allows posting of messages to the example stream"
}

resource "aws_api_gateway_api_key" "mod" {
  count = "${var.create_api_gateway}"
  name  = "${var.stream_name}-api-key"
}

resource "aws_api_gateway_usage_plan" "mod" {
  count = "${var.create_api_gateway}"
  name  = "${var.stream_name}-plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.mod.id}"
    stage  = "${aws_api_gateway_deployment.mod.stage_name}"
  }
}

resource "aws_api_gateway_usage_plan_key" "mod" {
  count         = "${var.create_api_gateway}"
  key_id        = "${aws_api_gateway_api_key.mod.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.mod.id}"
}

resource "aws_api_gateway_deployment" "mod" {
  count       = "${var.create_api_gateway}"
  depends_on  = ["aws_api_gateway_integration.list_streams", "aws_api_gateway_integration.describe_stream", "aws_api_gateway_integration.put_record"]
  rest_api_id = "${aws_api_gateway_rest_api.mod.id}"
  stage_name  = "${var.environment_name}"
}
