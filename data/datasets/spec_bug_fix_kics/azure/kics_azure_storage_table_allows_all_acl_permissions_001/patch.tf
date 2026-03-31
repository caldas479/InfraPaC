resource "azurerm_storage_table" "my_table_name" {
	name = "my_table_name"
	storage_account_name = "mystoragexxx"
	acl {
		id = "someid-1XXXXXXXXX"
		access_policy {
			expiry = "2022-10-03T05:05:00.0000000Z"
			permissions = "rwd"
			start = "2021-05-28T04:05:00.0000000Z"
		}
	}
}
