resource "azurerm_resource_group" "xroad" {
  name = "rg-xroad-${var.env}"
  location = var.location

  tags = merge(var.tags, var.envTags)
}

module "xroad-securityserver-1" {
  source               = "../vm"
  env = var.env

  tags = var.tags
  envTags = var.envTags
  zone = "1"
  username = var.username
  organization = var.organization
  organization_dns_fragment = var.organization_dns_fragment
  location = var.location
  vm_username = var.vm_username
  ssh_pubkey = var.ssh_pubkey
  vm_password = var.vm_password
  firewall_whitelist = var.firewall_whitelist
  vm_sku = var.vm_sku
  xroad_resource_group_name = azurerm_resource_group.xroad.name
  ops_resource_group_name = var.ops_resource_group_name
  rsv_name = var.rsv_name
  rsv_policy_id = var.rsv_policy_id
  psql_password = var.psql_password
  xrd_webadmin_password = var.xrd_webadmin_password
  data_collection_rule_id = var.data_collection_rule_id
  subnet_xroadvm_id = azurerm_subnet.snet-xroadvm.id
  automatic_update_reboot_time = var.automatic_update_reboot_time
  subnet_psql_id = azurerm_subnet.snet-psql.id
  psql_pdns_zone_id = var.psql_pdns_zone_id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pdns-vnet-link]
}

module "xroad-securityserver-2" {
  source               = "../vm"
  env                  = "prd"

  tags = var.tags
  envTags = var.envTags
  zone = "2"
  username = var.username
  organization = var.organization
  organization_dns_fragment = var.organization_dns_fragment
  location = var.location
  vm_username = var.vm_username
  ssh_pubkey = var.ssh_pubkey
  vm_password = var.vm_password
  firewall_whitelist = var.firewall_whitelist
  vm_sku = var.vm_sku
  xroad_resource_group_name = azurerm_resource_group.xroad.name
  ops_resource_group_name = var.ops_resource_group_name
  rsv_name = var.rsv_name
  rsv_policy_id = var.rsv_policy_id
  psql_password = var.psql_password
  xrd_webadmin_password = var.xrd_webadmin_password
  data_collection_rule_id = var.data_collection_rule_id
  subnet_xroadvm_id = azurerm_subnet.snet-xroadvm.id
  automatic_update_reboot_time = var.automatic_update_reboot_time
  subnet_psql_id = azurerm_subnet.snet-psql.id
  psql_pdns_zone_id = var.psql_pdns_zone_id

  count                = var.env == "prd" ? 1 : 0
  depends_on = [azurerm_private_dns_zone_virtual_network_link.pdns-vnet-link]
}
