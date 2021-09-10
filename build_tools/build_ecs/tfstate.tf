terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tfstate-build-ecs"
    region = "us-east-1"
    key = "terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-build-ecs"
  versioning {
    enabled = true
  }
}