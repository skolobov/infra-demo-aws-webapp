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