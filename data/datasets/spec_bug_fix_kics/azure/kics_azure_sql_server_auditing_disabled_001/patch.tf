resource "azurerm_sql_server" "positive1" {
  name = "mssqlserver"
  resource_group_name = azurerm_resource_group.example.name
  location = azurerm_resource_group.example.location
  version = "12.0"
  administrator_login = "mradministrator"
  administrator_login_password = var.administrator_login_password
  extended_auditing_policy {
    enabled = true
  }
}

variable "administrator_login_password" { default = "thisIsDog11" }
