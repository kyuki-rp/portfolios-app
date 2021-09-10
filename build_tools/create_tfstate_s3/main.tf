provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "default" {
  bucket = "tfstate-u5n1k2x1"
  versioning {enabled = true}
}