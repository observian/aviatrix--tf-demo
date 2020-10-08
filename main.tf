terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Observian"

    workspaces {
      name = "aviatrix--tf-demo"
    }
  }

  required_providers {
    aws = {
      version = "~>2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
