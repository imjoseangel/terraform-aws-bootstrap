terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  # Configuration options
  default_tags {
    tags = {
      Enviroment = var.environment
      Project    = var.project
    }
  }
  region = var.region
}
