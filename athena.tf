# Create an S3 bucket
resource "aws_s3_bucket" "athena-metabase-data-test" {
    bucket = "athena-metabase-data-test"
}

resource "aws_s3_bucket" "athena-metabase-results-test" {
    bucket = "athena-metabase-results-test"
}

resource "aws_s3_object" "accounts" {
  bucket = aws_s3_bucket.athena-metabase-data-test.bucket
  source    = "data/accounts.csv"
  key = "accounts/accounts.csv"
}

resource "aws_s3_object" "analytic_events" {
  bucket = aws_s3_bucket.athena-metabase-data-test.bucket
  source    = "data/analytic_events.csv"
  key = "analytic_events/analytic_events.csv"
}

resource "aws_s3_object" "feedback" {
  bucket = aws_s3_bucket.athena-metabase-data-test.bucket
  source    = "data/feedback.csv"
  key = "feedback/feedback.csv"
}

resource "aws_s3_object" "invoices" {
  bucket = aws_s3_bucket.athena-metabase-data-test.bucket
  source    = "data/invoices.csv"
  key = "invoices/invoices.csv"
}

# Create a Glue crawler
resource "aws_glue_crawler" "sample-crawler" {
    name            = "sample-crawler"
    database_name   = aws_glue_catalog_database.s3-data-source.name
    role            = data.aws_iam_role.glue-service-role.arn
    s3_target {
        path = "s3://${aws_s3_bucket.athena-metabase-data-test.bucket}"
    }
}

# Create a Glue catalog database
resource "aws_glue_catalog_database" "s3-data-source" {
    name = "s3-data-source"
}

# Create a policy for Metabase
resource "aws_iam_policy" "metabase-policy" {
    name        = "metabase-policy"
    description = "Policy for Metabase"
    policy      = file("policies/metabase-policy.json")
}

# Create a specific CLI user for Metabase
resource "aws_iam_user" "metabase-cli-user" {
    name = "metabase-cli-user"
}

# Create an access key for the user
resource "aws_iam_access_key" "metabase-cli-key" {
    user = aws_iam_user.metabase-cli-user.name
}

# Attach the policy to the user, don't do this in a production environment and please use groups
resource "aws_iam_user_policy_attachment" "metabase-policy-attachment" {
    user       = aws_iam_user.metabase-cli-user.name
    policy_arn = aws_iam_policy.metabase-policy.arn
}