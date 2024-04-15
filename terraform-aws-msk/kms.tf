resource "aws_kms_key" "msk_cluster" {
  count = var.create ? 1 : 0

  description = "chave KMS para o cluster MSK"
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

resource "aws_kms_alias" "msk_cluster_kms_key_alias" {
  count = var.create ? 1 : 0

  name          = "alias/AmazonMSK_${var.cluster_name}"
  target_key_id = aws_kms_key.msk_cluster[0].key_id

  depends_on = [ aws_kms_key.msk_cluster ]
}

resource "aws_kms_key" "cloudwatch_log_group_msk_cluster" {
  count = var.create ? 1 : 0

  description = "chave KMS para o cloudwatch log group do cluster MSK"
  policy      = <<POLICY
{
 "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
      {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "logs.${data.aws_region.current.name}.amazonaws.com"
        },
        "Action": [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        "Resource": "*",
        "Condition": {
          "ArnEquals": {
            "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:AmazonMSK_${var.cloudwatch_log_group_name}"
          }
        }
      }    
    ]
}
POLICY

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.cloudwatch_log_group_name}"
    },
    var.tags
  )
}

resource "aws_kms_alias" "cloudwatch_log_group_msk_cluster_kms_key_alias" {
  count = var.create ? 1 : 0

  name          = "alias/AmazonMSK_${var.cloudwatch_log_group_name}"
  target_key_id = aws_kms_key.cloudwatch_log_group_msk_cluster[0].key_id

  depends_on = [ aws_kms_key.cloudwatch_log_group_msk_cluster ]
}

resource "aws_kms_key" "secrets_manager" {
  count = var.create ? 1 : 0

  description = "chave KMS para o secrets manager do usuario do MSK cluster"
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