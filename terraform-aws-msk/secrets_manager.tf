resource "random_password" "this" {
  count = var.create && var.auto_generate_password && var.password == null ? 1 : 0

  length           = 16
  special          = true
  upper            = true
  lower            = true
  override_special = "!@#$_-"
}

resource "aws_secretsmanager_secret" "this" {
  count = var.create ? 1 : 0

  name       = "AmazonMSK_${var.secret_name}"
  kms_key_id = aws_kms_key.secrets_manager[0].id

  tags = merge(
    {
      "Name" : "AmazonMSK_${var.secret_name}"
    },
    var.tags
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.create ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode({ username = var.username, password = local.password })

  depends_on = [ aws_secretsmanager_secret.this ]
}

resource "aws_secretsmanager_secret_policy" "this" {
  count      = var.create ? 1 : 0
  secret_arn = aws_secretsmanager_secret.this[0].arn
  policy     = <<POLICY
{
  "Version" : "2012-10-17",
  "Statement" : [ {
    "Sid": "AWSKafkaResourcePolicy",
    "Effect" : "Allow",
    "Principal" : {
      "Service" : "kafka.amazonaws.com"
    },
    "Action" : "secretsmanager:getSecretValue",
    "Resource" : "${aws_secretsmanager_secret.this[0].arn}"
  } ]
}
POLICY
}