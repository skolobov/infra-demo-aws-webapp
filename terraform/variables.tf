variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-central-1"
}

variable "prefix" {
  description = "The prefix for resource names"
  type        = string
  default     = "hello-world"
}

variable "k8s_workload_namespace" {
  description = "Name of Kubernetes namespace to deploy the workload in"
  type        = string
  default     = "hello-world"
}

variable "k8s_workload_name" {
  description = "Name of Kubernetes workload"
  type        = string
  default     = "hello-world"
}
