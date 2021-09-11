variable "tfstate_s3bucketname" {}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "default" {
  bucket = var.tfstate_s3bucketname
  versioning {enabled = true}
}