provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tfstate-push-ecr"
    region = "ap-northeast-1"
    key = "tf_push_ecr.tfstate"
    encrypt = true
  }
}