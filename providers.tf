terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

provider "aws" {
  profile = "tf-technical-user"
  region  = "eu-central-1"
  default_tags {
    tags = {
      Owner     = "John Doe"
      NameSpace = "AA Terraform Basics"
      Managed   = "Terraform"
      Project   = "Phoenix"
      Name      = "Oops, I forgot to put the name on this resource"
    }
  }
}
