provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-push-ecr"
  versioning {
    enabled = true
  }
}

terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tfstate-push-ecr"
    region = "us-east-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}