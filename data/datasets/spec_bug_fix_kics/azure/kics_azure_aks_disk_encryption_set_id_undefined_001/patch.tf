resource "azurerm_kubernetes_cluster" "positive" {
	name = "example-aks1"
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	dns_prefix = "exampleaks1"

	default_node_pool {
		name = "default"
		node_count = 1
		vm_size = "Standard_D2_v2"
	}
	disk_encryption_set_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Compute/diskEncryptionSets/example-des"
}
