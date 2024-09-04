# infra-demo-aws-webapp

This project demonstrates a simple web application deployment to AWS.
The application is written in [Python](https://www.python.org) using [Flask](https://flask.palletsprojects.com/en/3.0.x/).

The CI/CD pipeline is configured using [GitHub Actions](https://github.com/features/actions) to build and push the [Docker](https://www.docker.com) image to AWS [Elastic Container Registry](https://aws.amazon.com/ecr/), and then deploy the application packaged with [Helm](https://helm.sh) to a [Kubernetes](https://kubernetes.io) cluster in [AWS EKS](https://aws.amazon.com/eks/).

The prerequisite infrastructure is described as code in [HCL](https://developer.hashicorp.com/terraform/language) and provisioned using [Terraform Cloud](https://www.hashicorp.com/products/terraform).

## Project Structure

This repository has the following main components:

- [app](app): Python application code and Docker image packaging
- [chart](chart): Helm chart for deploying application to Kubernetes
- [terraform](terraform): Infrastructure as Code (IaC) for provisioning the AWS EKS cluster and related resources using Terraform

## Setup Instructions

### Prerequisite Tools

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/)
- [`helm`](https://helm.sh/docs/intro/install/)
- [`terraform`](https://developer.hashicorp.com/terraform/install)
- [`aws`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### 1. Clone the Repository

```shell
git clone https://github.com/skolobov/infra-demo-aws-webapp.git
cd infra-demo-aws-webapp
```

### 2. Deploy Infrastructure using Terraform

Navigate to the [terraform](terraform) directory and follow the instructions
there to provision the required AWS cloud infrastructure.

### 3. Build and Push Docker Image

Python application code is located in the [app](app) directory.
It also contains a [`Dockerfile`](app/Dockerfile) to build the Docker image.

The image is built and pushed to the GitHub Container Registry (GHCR) automatically by GitHub Actions [`build`](.github/workflows/build.yml) workflow
on every push to the main branch, normally after merging a PR.

The following [checks](.github/workflows/checks.yml) are also run on every PR:

- GitHub [Super-Linter](https://github.com/super-linter/super-linter) for code linting and static analysis

### 4. Deploy Application using Helm

Once the Docker image is published to ECR, the same workflow deploys the application
to the Kubernetes cluster using Helm.

Please refer to the Helm chart in the [chart](chart) directory for more details.

Currently, the CI/CD is configured to deploy the application to the dedicated `hello-world` namespace in the Kubernetes cluster, creating it if it doesn't exist.

The application is exposed via `Ingress` and a `LoadBalancer` service type and it can be accessed using something like this (example assumes macOS):

```shell
open http://$(kubectl get ingress --namespace hello-world hello-world-chart --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}") 
```

## Author

[Sergei Kolobov](mailto:skolobov@gmail.com)
