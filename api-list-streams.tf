resource "aws_api_gateway_resource" "streams" {
  count       = "${var.create_api_gateway}"
  rest_api_id = "${aws_api_gateway_rest_api.mod.id}"
  parent_id   = "${aws_api_gateway_rest_api.mod.root_resource_id}"
  path_part   = "streams"
}

resource "aws_api_gateway_method" "list_streams" {
  count            = "${var.create_api_gateway}"
  rest_api_id      = "${aws_api_gateway_rest_api.mod.id}"
  resource_id      = "${aws_api_gateway_resource.streams.id}"
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "list_streams" {
  count                   = "${var.create_api_gateway}"
  rest_api_id             = "${aws_api_gateway_rest_api.mod.id}"
  resource_id             = "${aws_api_gateway_resource.streams.id}"
  http_method             = "${aws_api_gateway_method.list_streams.http_method}"
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:${var.aws_region}:kinesis:action/ListStreams"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  credentials             = "${aws_iam_role.gateway_execution_role.arn}"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-amz-json-1.1'"
  }

  # Passthrough the JSON response
  request_templates {
    "application/json" = <<EOF
{}
EOF
  }
}

resource "aws_api_gateway_method_response" "list_streams_ok" {
  count       = "${var.create_api_gateway}"
  depends_on  = ["aws_api_gateway_method.list_streams"]
  rest_api_id = "${aws_api_gateway_rest_api.mod.id}"
  resource_id = "${aws_api_gateway_resource.streams.id}"
  http_method = "${aws_api_gateway_method.list_streams.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "list_streams_ok" {
  count       = "${var.create_api_gateway}"
  rest_api_id = "${aws_api_gateway_rest_api.mod.id}"
  resource_id = "${aws_api_gateway_resource.streams.id}"
  http_method = "${aws_api_gateway_method.list_streams.http_method}"
  status_code = "${aws_api_gateway_method_response.list_streams_ok.status_code}"

  # Passthrough the JSON response
  response_templates {
    "application/json" = <<EOF
EOF
  }
}
