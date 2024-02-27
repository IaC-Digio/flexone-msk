module "msk_cluster" {
  source = "./terraform-aws-msk"
  create = true

  #- geral
  cluster_name    = "Example-Cluster"
  cluster_version = "3.5.1"
  region = var.region
  node_numbers    = 3
  instance_type   = "kafka.t3.small"
  volume_size     = 10

  #- usuario de autenticacao no MSK
  auto_generate_password = true
  secret_name            = "Example-Cluster-Admin-User"
  username               = "admin"

  #- rede
  subnet_ids = local.public_subnet_ids
  vpc_id     = data.aws_vpc.vpc.id

  #- security group
  create_sg                  = true
  security_group_name        = "Example-Cluster-SG"
  security_group_description = "Example-Cluster SG"
  ingress_rules_with_cidr_blocks = [
    {
      from_port   = 9096
      to_port     = 9096
      protocol    = "tcp"
      description = "allowing SASL/SCRAM authentication from VPC CIDR"
      cidr_blocks = "10.0.0.0/16"
    },
  ]
  egress_rules_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "allow all outside"
      cidr_blocks = "10.0.0.0/16"
    },
  ]

  ingress_rules_with_security_group_id = []
  egress_rules_with_security_group_id  = []

  security_groups_ids = []

  #- logging
  cloudwatch_log_group_name = "Example-Cluster-Logs"
  log_group_retention       = 30

  #- tags
  tags = var.tags
}