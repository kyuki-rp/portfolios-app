provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "tfstate-build-ecs"
    region = "ap-northeast-1"
    key = "tf_build_ecs.tfstate"
    encrypt = true
  }
}

