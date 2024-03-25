# xroad installation scripts create databases and users

resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = "psql-${var.organization_dns_fragment}-${var.zone}-xroad-${var.env}"
  resource_group_name   = var.xroad_resource_group_name
  location               = var.location
  version                = "15"
  administrator_login    = "postgres"
  administrator_password = var.psql_password

  storage_mb                   = 32768
  sku_name                     = "B_Standard_B1ms"
  backup_retention_days        = 30
  geo_redundant_backup_enabled = var.env == "prd" ? true : false
  auto_grow_enabled            = true

  # Is in fact required for redeployments
  zone = var.zone

  delegated_subnet_id = var.subnet_psql_id
  private_dns_zone_id = var.psql_pdns_zone_id

  tags = merge(var.tags, var.envTags)
}

# We must allowlist the HSTORE datatype before xroad setup
resource "azurerm_postgresql_flexible_server_configuration" "hstore" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.psql.id
  value     = "HSTORE"
}

output "psqlid" {
  value = azurerm_postgresql_flexible_server.psql.id
}
