locals {
  password            = var.create && var.auto_generate_password && var.password == null ? random_password.this[0].result : var.password
  security_groups_ids = var.create && var.create_sg ? setunion([ aws_security_group.this[0].id ], var.security_groups_ids) : var.security_groups_ids
}