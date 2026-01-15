resource "azurerm_key_vault_secret" "positive" {
  name         = "secret-sauce"
  value        = "szechuan"
  content_type = "application/octet-stream"
  key_vault_id = azurerm_key_vault.example.id
}
