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

      iam_role_additional_policies = {
        ecr_read_only = aws_iam_policy.eks_ecr_read_only.arn,
      }
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    github_actions = {
      principal_arn = module.github_actions_iam_role.iam_role_arn
      policy_associations = {
        deploy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"
          access_scope = {
            type = "namespace"
            namespaces = [
              "kube-system",
              var.k8s_namespace,
            ]
          }
        }
      },
    }
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.k8s_namespace
  }
}
