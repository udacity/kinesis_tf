variable "stream_name" {}

variable "create_api_gateway" {
  default = false
}

variable "shard_count" {
  default = "1"
}

variable "retention_period" {
  default = "48"
}

variable "environment_name" {}

variable "application_name" {}

variable "aws_region" {}

variable "lambda_s3_bucket" {}

variable "lambda_s3_key" {}

output "invoke_url" {
  value = "${aws_api_gateway_deployment.mod.invoke_url}"
}
