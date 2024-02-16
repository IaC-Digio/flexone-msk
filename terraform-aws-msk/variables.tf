variable "username" {
  type = string
  validation {
    condition     = var.username != ""
    error_message = "necessario informar o nome de usuario de conexao no MSK"
  }
}

variable "password" {
  type      = string
  default   = null
  sensitive = true
}

variable "log_group_retention" {
  type = number
  default = 30
}

variable "secret_name" {
  type = string
  validation {
    condition     = var.secret_name != ""
    error_message = "necessario informar o nome do Secrets Manager para armazenamento da senha do usuario de conexao no MSK"
  }
}

variable "auto_generate_password" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cloudwatch_log_group_name" {
  type = string
  validation {
    condition     = var.cloudwatch_log_group_name != ""
    error_message = "necessario informar o nome do Cloud Watch Log Group para armazenamento dos logs do cluster"
  }
}

variable "vpc_id" {
  type = string
  default = null
  validation {
    condition     = var.vpc_id != ""
    error_message = "necessario informar o VPC ID"
  }
}

variable "subnet_ids" {
  type    = list(string)
  default = null
  validation {
    condition     = length(var.subnet_ids) > 1
    error_message = "necessario informar uma lista de subnet IDs"
  }
}

variable "security_groups_ids" {
  type    = list(string)
  default = null
}

variable "ingress_rules_with_cidr_blocks" {
  type = list(any)
}

variable "egress_rules_with_cidr_blocks" {
  type = list(any)
}

variable "ingress_rules_with_security_group_id" {
  type = list(any)
}

variable "egress_rules_with_security_group_id" {
  type = list(any)
}

variable "create" {
  type    = bool
  default = null
}

variable "create_sg" {
  type    = bool
  default = null
}

variable "security_group_name" {
  type = string
  validation {
    condition     = var.security_group_name != ""
    error_message = "necessario o nome do security group do cluster"
  }
}

variable "security_group_description" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = null
  validation {
    condition     = var.cluster_name != ""
    error_message = "necessario informar o nome do cluster"
  }
}

variable "cluster_version" {
  type    = string
  default = null
  validation {
    condition     = var.cluster_version != ""
    error_message = "necessario informar a versao do cluster"
  }
}

variable "instance_type" {
  type    = string
  default = null
  validation {
    condition     = var.instance_type != ""
    error_message = "necessario informar o tipo de instancia do cluster"
  }
}

variable "volume_size" {
  type    = number
  default = null
  validation {
    condition     = var.volume_size != ""
    error_message = "necessario informar o tamanho do disco do cluster"
  }
}

variable "node_numbers" {
  type    = number
  default = null
  validation {
    condition     = var.node_numbers != ""
    error_message = "necessario informar a quantidade de nodes do cluster"
  }
}