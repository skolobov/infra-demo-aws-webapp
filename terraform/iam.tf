module "github_actions_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.46.0" # checkov:skip=CKV_TF_1

  create_role  = true
  role_name    = "${var.prefix}-github-actions-role"
  provider_url = aws_iam_openid_connect_provider.github_actions.url

  oidc_subjects_with_wildcards = [
    "repo:skolobov/infra-demo-aws-webapp:*",
  ]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  ]

  max_session_duration = 7200
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}
