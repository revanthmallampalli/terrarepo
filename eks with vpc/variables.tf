variable "aws_region" {
  default = "us-east-1"
}

variable "name" {
  default = "revanth-eks-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "kubernetes_version" {
  default = 1.27
}