variable "tags" {
  type    = map(string)
  default = {
    terraform  = "true"
  }
}

variable "create" {
  type    = bool
  default = true
}

variable "region" {
  type = string
  default = "sa-east-1"
}