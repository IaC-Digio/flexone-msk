variable "tags" {
  type    = map(string)
  default = {}
}

variable "create" {
  type    = bool
  default = true
}

variable "region" {
  type = string
  default = "us-east-2"
}