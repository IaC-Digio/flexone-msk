data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "vpc" {
  id = "<VPC ID>"
}

data "aws_subnets" "private" {
  for_each = toset(data.aws_availability_zones.available.zone_ids)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["<Filtro das Subnets>*"]
  }

  filter {
    name   = "availability-zone-id"
    values = ["${each.value}"]
  }
}

data "aws_security_group" "security_group" {
  id = "<Security Group ID>"
}