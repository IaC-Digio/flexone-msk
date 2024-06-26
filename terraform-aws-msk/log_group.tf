resource "aws_cloudwatch_log_group" "this" {
  count = var.create ? 1 : 0

  name              = "AmazonMSK_${var.cloudwatch_log_group_name}"
  retention_in_days = var.log_group_retention
  kms_key_id = aws_kms_key.cloudwatch_log_group_msk_cluster[0].arn

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.cloudwatch_log_group_name}"
    },
    var.tags
  )
}