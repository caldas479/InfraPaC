resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [22]
    source_address_prefixes   = ["10.0.0.0/24"]
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [80]
    source_address_prefixes   = ["10.0.0.0/24"]
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [443]
    source_address_prefixes   = ["10.0.0.0/24"]
    destination_address_prefix = "VirtualNetwork"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes       = ["10.0.1.0/24"]
  service_endpoints      = ["Microsoft.Storage"]
}

resource "azurerm_public_ip" "example" {
  name                    = "example-pip"
  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  allocation_method       = "Static"
}

resource "azurerm_network_interface" "example" {
  name                      = "example-nic"
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                  = "example-vm"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_D2s_v3"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "internal"
    address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "eastus"
}
