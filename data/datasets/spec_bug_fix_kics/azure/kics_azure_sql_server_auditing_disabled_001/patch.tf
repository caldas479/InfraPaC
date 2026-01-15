resource "azurerm_sql_server" "positive1" {
	name = "mssqlserver"
	resource_group_name = azurerm_resource_group.example.name
	location = azurerm_resource_group.example.location
	version = "12.0"
	administrator_login = "mradministrator"
	administrator_login_password = var.password
	extended_auditing_policy {
		enabled = true
		audit_actions_groups = ["SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP", "FAILED_DATABASE_AUTHENTICATION_GROUP"]
	}
}

variable "password" {
	sensitive = true
	default = "thisIsDog11"
}
