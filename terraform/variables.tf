// --- terraform/variables.tf ---
// This file defines variables you can easily change

variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name for your EKS cluster."
  type        = string
  default     = "todo-app-cluster"
}
