resource "azurerm_cosmosdb_account" "positive1" {
	name = "example"
	is_virtual_network_filter_enabled = true
	ip_range_filter = "0.0.0.0/0"
}
