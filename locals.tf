locals {
  private_subnet_ids = [for k, v in data.aws_subnets.private_subnets_by_zone : v.ids[0]] # just need one of them
  private_subnets_cidr_blocks = [ for k, v in data.aws_subnet.subnet_ids : v.cidr_block ]
  msk-cluster = "flexone"
}