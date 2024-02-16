variable "tags" {
  type    = map(string)
  default = {
    terraform = "true"
    owner = "danilo.lopes"
    informacao = "desenvolvimento de terraform para a Digio"
  }
}

variable "create" {
  type    = bool
  default = true
}

variable "region" {
  type = string
  default = "us-east-2"
}