variable "tags" {
  type = object({
    CreateDate = string
    CreatedBy  = string
  })
}
variable "envTags" {
  type = object({
    Environment = string
  })
}

variable "username" {
  type = string
}

variable "organization" {
  type = string
}

variable "organization_dns_fragment" {
  type = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$", var.organization_dns_fragment))
    error_message = "The DNS segment must start and end with a letter or digit, be 1 to 63 characters long, and can contain hyphens but not start or end with them."
  }
}

variable "env" {
  type        = string
}

variable "location" {
  type    = string
}

variable "vm_username" {
  type = string
}

variable "ssh_pubkey" {
  type        = string
}

variable "vm_password" {
  type        = string
  ephemeral = true
  sensitive = true
}

variable "firewall_whitelist" {
  type        = set(string)
}

variable "vm_sku" {
  type    = string
}

variable "ops_resource_group_name" {
  type = string
}

variable "rsv_name" {
  type = string
}

variable "rsv_policy_id" {
  type = string
}

variable "psql_password" {
  type = string
  ephemeral = true
  sensitive = true
}
variable "xrd_webadmin_password" {
  type = string
  ephemeral = true
  sensitive = true
}
variable "data_collection_rule_id" {
  type = string
}
variable "actiongroup_id" {
  type = string
}
variable "log_analytics_workspace_name" {
  type = string
}
variable "log_analytics_workspace_id" {
  type = string
}
variable "vnetAddressPrefix" {
  type    = string
}
variable "vmSubnetAddressPrefix" {
  type    = string
}
variable "psqlSubnetAddressPrefix" {
  type    = string
}
variable "automatic_update_reboot_time" {
  type = string
}
variable "psql_pdns_zone" {
  type = string
}
variable "psql_pdns_zone_id" {
  type = string
}
