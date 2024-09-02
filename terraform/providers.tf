terraform {
  required_version = ">= 1.1.1"


  cloud {
    organization = "skolobov"

    workspaces {
      name = "infra-demo-aws-webapp"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Terraform" = "true"
      "Project"   = "infra-demo-aws-webapp"
    }
  }
}
