terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = local.region
  profile = local.profile
}

module "vpc" {
  source             = "./modules/vpc"
  cidr               = "10.0.0.0/16"
  subnet            = "10.0.16.0/24"
  availability_zones = local.region
}
