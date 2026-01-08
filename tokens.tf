###############################
# Intentional insecure Terraform
# - For scanner testing only
# - Contains hard-coded credentials, secrets, public bucket, open SG, and vulnerable package installs
###############################
# ------------------------
# LOCAL VALUES INCLUDING AN OAUTH TOKEN (HARD-CODED SECRET)
# ------------------------
locals {
  # Fake OAuth/GitHub token intentionally hard-coded for detection
  github_oauth_token = "ghp_FAKE_GITHUB_OAUTH_TOKEN_FOR_TESTING"
  slack_token        = "xoxp-FAKE-SLACK-TOKEN-123456"
}
# Put a file containing a "secret" into the bucket (for scanners that look for PII/secrets in storage)
resource "aws_s3_bucket_object" "secret_file" {
  bucket = aws_s3_bucket.public_bucket.id
  key    = "secrets/credentials.txt"
  content = <<EOT
GITHUB_OAUTH=${local.github_oauth_token}
SLACK_TOKEN=${local.slack_token}
EOT
  acl = "public-read"  # insecure: makes this secret file readable by anyone
}
# ------------------------
# LOCAL FILE (MIMICING A CONFIG FILE WITH SECRET)
# ------------------------
resource "local_file" "app_config" {
  content = <<-CFG
  {
    "db_host": "10.0.0.5",
    "db_user": "appuser",
    "db_password": "P@ssw0rd_FAKE_DB_PASSWORD",   # hard-coded DB password
    "third_party": {
      "client_id": "fake-client-id-123",
      "client_secret": "fake-client-secret-456"
    }
  }
  CFG
  filename = "${path.module}/test_app_config.json"
}
# ------------------------
# OUTPUTS (so scanners can index outputs)
# ------------------------
output "s3_bucket_name" {
  value = aws_s3_bucket.public_bucket.bucket
}
output "vulnerable_instance_id" {
  value = aws_instance.vulnerable_host.id
}
