provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "default" {
  bucket = "tfstate-u5n1k2x0"
  versioning {enabled = true}
}