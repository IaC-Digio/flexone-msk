terraform {
  required_providers {
    aws = {
      version = "5.33.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = ""
  region = "us-east-2"
  allowed_account_ids = []
  default_tags {
    tags = {
      workload    = "matera"
      application = "flexone"
      bu          = "infraestrutura"
      monitoring  = "zabbix"
      cost_center = "ti_infraestrutura"
    }
  }
}