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