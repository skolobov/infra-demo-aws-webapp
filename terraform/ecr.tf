module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.2.1" # checkov:skip=CKV_TF_1

  repository_name = var.prefix

  repository_read_write_access_arns = [
    module.github_actions_iam_role.iam_role_arn,
  ]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus   = "tagged",
          countType   = "imageCountMoreThan",
          countNumber = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_ecr_read_only" {
  name        = "${var.prefix}-eks-ecr-read-only"
  description = "Read-only access to ECR repository for EKS cluster"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = module.ecr.repository_arn
      }
    ]
  })
}
