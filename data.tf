data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [""]
  }
}

data "aws_subnets" "private_subnets_by_zone" {
  for_each = toset(data.aws_availability_zones.available.zone_ids)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [""]
  }

  filter {
    name   = "availability-zone-id"
    values = ["${each.value}"]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [""]
  }
}
data "aws_subnet" "subnet_ids" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}

data "aws_security_group" "security_group" {
  filter {
    name   = "tag:Name"
    values = [""]
  }
}