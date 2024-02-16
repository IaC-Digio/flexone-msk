locals {
  public_subnet_ids = [for k, v in data.aws_subnets.private : v.ids[0]] # just need one of them
}