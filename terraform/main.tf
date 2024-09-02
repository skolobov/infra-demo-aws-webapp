module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0" # checkov:skip=CKV_TF_1

  name = "${var.prefix}-vpc"

  cidr = "10.49.0.0/16"

  azs = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",
  ]
  public_subnets = [
    "10.49.1.0/24",
    "10.49.2.0/24",
    "10.49.3.0/24",
  ]
  private_subnets = [
    "10.49.11.0/24",
    "10.49.12.0/24",
    "10.49.13.0/24",
  ]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0" # checkov:skip=CKV_TF_1

  cluster_name    = "${var.prefix}-eks"
  cluster_version = "1.30"

  # EKS Addons
  cluster_addons = {
    aws-ebs-csi-driver     = {}
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    workers = {
      instance_types = [
        "t3.medium",
      ]

      min_size     = 1
      max_size     = 3
      desired_size = 2

    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
}
