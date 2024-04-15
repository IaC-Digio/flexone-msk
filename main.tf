module "msk_cluster" {
  source = "./terraform-aws-msk"
  create = true

  #- geral
  cluster_name    = "${local.msk-cluster}"
  cluster_version = "3.5.1"
  node_numbers    = 3
  instance_type   = "kafka.t3.small"
  volume_size     = 10

  #- usuario de autenticacao no MSK
  auto_generate_password = true
  secret_name            = "${local.msk-cluster}-Admin-User"
  username               = "admin"

  #- rede
  subnet_ids = local.private_subnet_ids
  vpc_id     = data.aws_vpc.vpc.id

  #- security group
  create_sg                  = true
  security_group_name        = "${local.msk-cluster}-sg"
  security_group_description = "${local.msk-cluster} sg"

  security_group_additional_rules = {
    sasl_scram_authentication = {
      type = "ingress"
      from_port = 9096
      to_port = 9096
      protocol = "tcp"
      description = ""
      cidr_blocks = local.private_subnets_cidr_blocks
    }

    allow_all_egress = {
      type = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "allow all to subnets"
      cidr_blocks = local.private_subnets_cidr_blocks
    }
  }

  security_groups_ids = []

  #- logging
  cloudwatch_log_group_name = "${local.msk-cluster}"
  log_group_retention       = 14

  #- tags
  tags = var.tags
}