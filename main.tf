terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

data "aws_iam_role" "glue-service-role" {
  name = "AWSGlueServiceRole"
}

output "glue_role_arn" {
  value = data.aws_iam_role.glue-service-role.arn
}

output "cli_id" {
  value = aws_iam_access_key.metabase-cli-key.id
  sensitive = true
}

output "cli_secret" {
  value = aws_iam_access_key.metabase-cli-key.secret
  sensitive = true
}

# To get the secrets run the following commands:
# terraform output -raw cli_id
# terraform output -raw cli_secret