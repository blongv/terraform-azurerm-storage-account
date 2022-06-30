# Common

variable "location_short" {
  description = "Short string for Azure location"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

# Storage account parameters

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Changing this forces a new resource to be created. Defaults to StorageV2."
  default     = "StorageV2"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`."
  default     = "Hot"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`."
  default     = "ZRS"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. "
  default     = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public."
  default     = false
}

variable "custom_domain_name" {
  type        = string
  description = "The Custom Domain Name to use for the Storage Account, which will be validated by Azure."
  default     = null
}

variable "use_subdomain" {
  type        = bool
  description = "Should the Custom Domain Name be validated by using indirect CNAME validation?"
  default     = false
}

variable "static_website_config" {
  type        = list(map(string))
  description = "Static website configurations list. Map object should contains `index_document` and `error_404_document` attributes."
  default     = []
}

# Identity
variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account."
  type        = list(string)
  default     = null
}

# Storage Firewall

variable "network_rules_enabled" {
  description = "Boolean to enable Network Rules on the Storage Account, requires `network_bypass`, `ip_rules`, `subnet_ids` or `default_firewall_action` correctly set if enabled."
  type        = bool
  default     = true
}

variable "network_bypass" {
  description = "Specifies whether traffic is bypassed for 'Logging', 'Metrics', 'AzureServices' or 'None'."
  type        = list(string)
  default     = ["None"]
}

variable "ip_rules" {
  description = "IPs to allow access to that storage account."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnets to allow access to that storage account."
  type        = list(string)
  default     = []
}

variable "default_firewall_action" {
  type        = string
  description = "Which default firewalling policy to apply. Valid values are `Allow` or `Deny`."
  default     = "Deny"
}

# Data protection

variable "storage_blob_data_protection" {
  description = "Storage account blob Data protection parameters."
  type = object({
    change_feed_enabled                       = bool
    versioning_enabled                        = bool
    delete_retention_policy_in_days           = number
    container_delete_retention_policy_in_days = number
    container_point_in_time_restore           = bool
  })
  default = {
    change_feed_enabled                       = true
    versioning_enabled                        = true
    delete_retention_policy_in_days           = 30
    container_delete_retention_policy_in_days = 30
    container_point_in_time_restore           = true
  }
}

# Threat protection
variable "advanced_threat_protection_enabled" {
  description = "Boolean flag which controls if advanced threat protection is enabled, see [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information."
  type        = bool
  default     = false
}
