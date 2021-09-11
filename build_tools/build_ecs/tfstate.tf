variable "tfstate_s3bucketname" {}

provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = var.tfstate_s3bucketname
    region = "us-east-1"
    key = "tf_build_ecs.tfstate"
    encrypt = true
  }
}

