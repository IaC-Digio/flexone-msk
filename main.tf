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
  
  ingress_rules_with_cidr_blocks = [
    {
      from_port   = 9096
      to_port     = 9096
      protocol    = "tcp"
      description = "allowing SASL/SCRAM authentication from VPC CIDR"
      cidr_blocks = ["10.26.0.0/16", "10.27.0.0/16"]
    }
  ]
  egress_rules_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "allow all outside"
      cidr_blocks = ["10.26.0.0/16", "10.27.0.0/16"]
    }
  ]

  ingress_rules_with_security_group_id = []
  egress_rules_with_security_group_id  = []
  security_groups_ids = []

  #- logging
  cloudwatch_log_group_name = "/msk/${local.msk-cluster}"
  log_group_retention       = 14

  #- tags
  tags = var.tags
}