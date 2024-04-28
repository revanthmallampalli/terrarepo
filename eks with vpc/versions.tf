terraform {
    required_version = ">=0.12"
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.29.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.47.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.4"
    }
  }
}