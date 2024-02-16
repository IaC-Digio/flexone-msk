output "mask_cluster_arn" {
  description = "amazon resource bame (ARN) of the MSK cluster"
  value       = try(module.msk_cluster.mask_cluster_arn, null)
}

output "msk_cluster_current_version" {
  description = "current version of the MSK cluster used for updates, e.g. `K13V1IB3VIYZZH`"
  value       = try(module.msk_cluster.current_version, null)
}

output "msk_cluster_log_group_arn" {
  description = "the amazon resource name (ARN) specifying the log group"
  value       = try(module.msk_cluster.log_group_arn, null)
}

output "bootstrap_brokers" {
  description = "comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster"
  value       = try(module.msk_cluster.bootstrap_brokers, null)
}