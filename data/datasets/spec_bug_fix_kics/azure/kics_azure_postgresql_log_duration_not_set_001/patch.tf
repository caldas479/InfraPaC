resource "azurerm_postgresql_configuration" "positive1" {
  name                = "log_duration"
  resource_group_name = "example1_resource_group_name"
  server_name         = "example1_server_name"
  value               = "ON"
}

resource "azurerm_postgresql_configuration" "positive2" {
  name                = "log_duration"
  resource_group_name = "example2_resource_group_name"
  server_name         = "example2_server_name"
  value               = "ON"
}

resource "azurerm_postgresql_configuration" "positive3" {
  name                = "log_duration"
  resource_group_name = "example3_resource_group_name"
  server_name         = "example3_server_name"
  value               = "ON"
}
