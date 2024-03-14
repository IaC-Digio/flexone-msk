resource "aws_kms_key" "kafka_cluster" {
  count = var.create ? 1 : 0

  description = "chave KMS para o cluster Kafka"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
POLICY

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.cluster_name}"
    },
    var.tags
  )
}

resource "aws_kms_alias" "kafka_cluster" {
  count = var.create ? 1 : 0

  name          = "alias/AmazonMSK_${var.cluster_name}"
  target_key_id = aws_kms_key.kafka_cluster[0].key_id

  depends_on = [ aws_kms_key.kafka_cluster ]
}

resource "aws_kms_key" "secrets_manager" {
  count = var.create ? 1 : 0

  description = "chave KMS para o secrets manager do usuario do cluster"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
POLICY

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.secret_name}"
    },
    var.tags
  )
}

resource "aws_kms_alias" "secrets_manager" {
  count = var.create ? 1 : 0

  name          = "alias/AmazonMSK_${var.secret_name}"
  target_key_id = aws_kms_key.secrets_manager[0].key_id

  depends_on = [ aws_kms_key.secrets_manager ]
}