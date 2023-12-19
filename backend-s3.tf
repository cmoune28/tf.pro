terraform {
  backend "s3" {
    bucket  = "vpro1738"
    key     = "terraform/backend"
    region  = "us-east-1"
    profile = "IAM_DevOps"
  }
}