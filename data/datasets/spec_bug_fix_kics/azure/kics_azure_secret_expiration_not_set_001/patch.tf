resource "azurerm_key_vault_secret" "positive1" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.example.id

  tags = {
    environment = "Production"
  }

  expiration_date = "2023-05-14T18:36:48Z"
}
