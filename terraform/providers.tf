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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
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

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}
