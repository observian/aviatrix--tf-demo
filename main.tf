terraform {
  required_providers {
    aws       = {
      version = "~>2.0"
    }
  }
}

provider "aws" {
  region              = var.aws_region
}