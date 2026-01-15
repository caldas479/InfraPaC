resource "azurerm_key_vault_secret" "positive1" {
	name = "secret-sauce"
	value = "szechuan"
	key_vault_id = azurerm_key_vault.example.id
	expiration_date = "2023-06-15T00:00:00Z"
	tags = {
	environment = "Production"
	}
}
