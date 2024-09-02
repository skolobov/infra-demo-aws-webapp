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
