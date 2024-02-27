resource "aws_msk_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_name  = var.cluster_name
  kafka_version = var.cluster_version

  number_of_broker_nodes = var.node_numbers

  client_authentication {
    sasl {
      scram = true
    }
  }

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = var.subnet_ids
    security_groups = local.security_groups_ids

    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size
      }
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.msk_cluster[0].arn
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster = true
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.this[0].name
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.cluster_name}"
    },
    var.tags
  )

  depends_on = [
    aws_security_group.this,
    aws_kms_alias.msk_cluster_kms_key_alias,
    aws_cloudwatch_log_group.this,
    aws_secretsmanager_secret.this
  ]
}

resource "aws_msk_scram_secret_association" "this" {
  count           = var.create ? 1 : 0
  cluster_arn     = aws_msk_cluster.this[0].arn
  secret_arn_list = [ aws_secretsmanager_secret.this[0].arn ]

  depends_on = [ aws_secretsmanager_secret_version.this, aws_msk_cluster.this ]
}