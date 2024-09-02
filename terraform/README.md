# Terraform Configuration for AWS EKS

This directory contains the Terraform configuration for provisioning an AWS EKS cluster and related resources.

## Setup Instructions

### Prerequisites

- Terraform
- AWS CLI configured with appropriate credentials
- Terraform Cloud (optional)

### 1. Log in to Terraform Cloud

If you are using Terraform Cloud, log in using the following command:

```shell
terraform login
```

### 2. Initialize Terraform

Navigate to the terraform directory and initialize Terraform with module upgrades:

```shell
terraform init --upgrade
```

### 3. (Optional) Configure Backend

By default, this configuration uses Terraform Cloud as the backend. To use a different Terraform Cloud organization or workspace, modify (or comment out to disable) the following `cloud` block in `providers.tf` file:

```hcl
  cloud {
    organization = "skolobov"

    workspaces {
      name = "infra-demo-aws-webapp"
    }
  }
```

### 4. Run Terraform Plan

Generate and review the execution plan:

```shell
terraform plan
```

### 5. Apply Terraform Changes

Apply the Terraform changes to create the EKS cluster and related resources:

```shell
terraform apply
```

### Outputs

After applying the configuration, the outputs will provide information about the created resources, such as the EKS cluster ID and endpoint.
