# Terraform module for creating Kinesis Applications
Supports:
  - backup to an s3 bucket via lambda -> firehose
  - optional API Gateway endpoints for writing to the stream

## Example usage

terraform.tf
```terraform
variable aws_access_key {
  type = "string"
}

variable aws_secret_key {
  type = "string"
}

variable aws_region {
  type    = "string"
  default = "us-east-1"
}
```

aws.tf
```terraform
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}
```

main.tf
```terraform
module "kinesis_tf" {
  source = "github.com/udacity/kinesis_tf"

  stream_name        = "example1"
  retention_period   = "48"
  environment_name   = "production"
  application_name   = "RegistrarTermImporter"
  aws_region         = "${var.aws_region}"
  create_api_gateway = true
}
```

From a shell:
```bashp
terraform plan
```
