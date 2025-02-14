# Diag settings / logs parameters

variable "logs_destinations_ids" {
  type        = list(string)
  description = <<EOD
List of destination resources IDs for logs diagnostic destination.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character.
EOD
}

variable "recovery_vault_logs_destinations_ids" {
  type        = list(string)
  description = <<EOD
List of destination resources IDs for logs diagnostic destination for the Recovery Vault.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character.
EOD
  default     = []
}

variable "cache_storage_account_logs_destinations_ids" {
  type        = list(string)
  description = <<EOD
List of destination resources IDs for logs diagnostic destination for the cache Storage Account.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character.
EOD
  default     = []
}


variable "cache_storage_account_logs_categories" {
  type        = list(string)
  description = "Log categories to send to destinations."
  default     = null
}

variable "cache_storage_account_logs_metrics_categories" {
  type        = list(string)
  description = "Metrics categories to send to destinations."
  default     = null
}

variable "cache_storage_account_diagnostic_settings_custom_name" {
  description = "Custom name of the diagnostics settings of the cache storage account, name will be 'default' if not set."
  type        = string
  default     = "default"
}
