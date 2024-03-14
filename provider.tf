terraform {
  required_providers {
    aws = {
      version = "5.33.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "homologacao"
  region = "sa-east-1"

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