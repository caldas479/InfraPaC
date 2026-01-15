resource "azurerm_security_center_contact" "positive" {
	phone = "+1-555-555-5555"
	email = "your_email@example.com"
	alert_notifications = true
	alerts_to_admins = true
}
