resource "aws_security_group" "this" {
  count = var.create && var.create_sg ? 1 : 0

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.cluster_name}"
    },
    var.tags
  )
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in merge(
    var.security_group_additional_rules
  ) : k => v }

  # Required
  security_group_id = aws_security_group.this[0].id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type

  # Optional
  description              = lookup(each.value, "description", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  self                     = lookup(each.value, "self", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

# resource "aws_security_group_rule" "ingress_rules_with_cidr_blocks" {
#   count = var.create && var.create_sg ? length(var.ingress_rules_with_cidr_blocks) : 0

#   security_group_id = aws_security_group.this[0].id
#   type              = "ingress"

#   cidr_blocks = compact(distinct(concat( var.ingress_rules_with_cidr_blocks[count.index]["cidr_blocks"] )))
#   description = var.ingress_rules_with_cidr_blocks[count.index]["description"]

#   from_port = var.ingress_rules_with_cidr_blocks[count.index]["from_port"]
#   to_port   = var.ingress_rules_with_cidr_blocks[count.index]["to_port"]
#   protocol  = var.ingress_rules_with_cidr_blocks[count.index]["protocol"]

#   depends_on = [ aws_security_group.this ]
# }

# resource "aws_security_group_rule" "egress_rules_with_cidr_blocks" {
#   count = var.create && var.create_sg ? length(var.egress_rules_with_cidr_blocks) : 0

#   security_group_id = aws_security_group.this[0].id
#   type              = "egress"

#   cidr_blocks = compact(distinct(concat( var.egress_rules_with_cidr_blocks[count.index]["cidr_blocks"] )))
#   description = var.egress_rules_with_cidr_blocks[count.index]["description"]

#   from_port = var.egress_rules_with_cidr_blocks[count.index]["from_port"]
#   to_port   = var.egress_rules_with_cidr_blocks[count.index]["to_port"]
#   protocol  = var.egress_rules_with_cidr_blocks[count.index]["protocol"]

#   depends_on = [ aws_security_group.this ]
# }

# resource "aws_security_group_rule" "ingress_rules_with_security_group_id" {
#   count = var.create && var.create_sg ? length(var.ingress_rules_with_security_group_id) : 0

#   security_group_id = aws_security_group.this[0].id
#   type              = "ingress"

#   source_security_group_id = var.ingress_rules_with_security_group_id[count.index]["source_security_group_id"]
#   description              = var.ingress_rules_with_security_group_id[count.index]["description"]

#   from_port = var.ingress_rules_with_security_group_id[count.index]["from_port"]
#   to_port   = var.ingress_rules_with_security_group_id[count.index]["to_port"]
#   protocol  = var.ingress_rules_with_security_group_id[count.index]["protocol"]

#   depends_on = [ aws_security_group.this ]
# }

# resource "aws_security_group_rule" "egress_rules_with_security_group_id" {
#   count = var.create && var.create_sg ? length(var.egress_rules_with_security_group_id) : 0

#   security_group_id = aws_security_group.this[0].id
#   type              = "egress"

#   source_security_group_id = var.egress_rules_with_security_group_id[count.index]["source_security_group_id"]
#   description              = var.egress_rules_with_security_group_id[count.index]["description"]

#   from_port = var.egress_rules_with_security_group_id[count.index]["from_port"]
#   to_port   = var.egress_rules_with_security_group_id[count.index]["to_port"]
#   protocol  = var.egress_rules_with_security_group_id[count.index]["protocol"]

#   depends_on = [ aws_security_group.this ]
# }