provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "default" {
  bucket = "terraform-state"
  versioning {enabled = true}
}