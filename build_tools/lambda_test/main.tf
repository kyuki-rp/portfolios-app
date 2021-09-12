provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tfstate-u5n1k2x1"
    key    = "tf_push_ecr.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
