terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.26"
    }
  }

  backend "s3" {
    bucket  = "sussybakaamongusimpostor"
    key     = "terraform.tfstate"
    region  = "eu-west-3"
    profile = "sussybaka"
  }
}

provider "aws" {
  region  = "eu-west-3"
  profile = "sussybaka"
}
