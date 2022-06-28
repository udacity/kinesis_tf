# Terraform module for creating Kinesis Applications

Creates:
- A kinesis stream
- An S3 bucket for backing up events
- Optionally A kinesis firehose to S3 for backing up every record
- Optionally A lambda to copy from the stream to the firehose
- Cloudwatch error logging for the firehose
- All applicable IAM roles and policies, including a read-only role for KCL applications
- (Optionally) an APIKey secured API gateway for posting to the stream from outside AWS (e.g. GAE)

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
  create_s3_backup = false
}
```

To get the module from github:
```bashp
terraform get
```

 # Archival Note 
 This repository is deprecated; therefore, we are going to archive it. However, learners will be able to fork it to their personal Github account but cannot submit PRs to this repository. If you have any issues or suggestions to make, feel free to: 
- Utilize the https://knowledge.udacity.com/ forum to seek help on content-specific issues. 
- Submit a support ticket along with the link to your forked repository if (learners are) blocked for other reasons. Here are the links for the [retail consumers](https://udacity.zendesk.com/hc/en-us/requests/new) and [enterprise learners](https://udacityenterprise.zendesk.com/hc/en-us/requests/new?ticket_form_id=360000279131).