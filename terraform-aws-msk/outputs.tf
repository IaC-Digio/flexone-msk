output "arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster"
  value       = try(aws_msk_cluster.this[0].arn, null)
}

output "bootstrap_brokers" {
  description = "comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster"
  value = try(aws_msk_cluster.this[0].bootstrap_brokers_sasl_scram, null)
}

output "current_version" {
  description = "current version of the MSK Cluster used for updates, e.g. `K13V1IB3VIYZZH`"
  value       = try(aws_msk_cluster.this[0].current_version, null)
}

output "log_group_arn" {
  description = "the Amazon Resource Name (ARN) specifying the log group"
  value       = try(aws_cloudwatch_log_group.this[0].arn, null)
}