provider "azurerm" {
    version = "2.20.0"
    subscription_id = var.subscriptionID

    features {}
}

resource "azurerm_network_security_group" "twdemonsg" {
  name                = "twdemonsg"
  location            = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_network_security_rule" "Port80" {
  name                        = "Allow80"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.twdemonsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.twdemonsg.name
}

resource "azurerm_network_security_rule" "Port443" {
  name                        = "Allow443"
  priority                    = 510
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.twdemonsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.twdemonsg.name
}

resource "azurerm_virtual_network" "tw-vnet-prod" {
  name                = "tw-vnet-prod"
  location            = var.location
  resource_group_name = var.resourceGroupName
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["8.8.8.8", "8.8.4.4"]

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_subnet" "subnet-prod" {
  name                 = "subnet-prod"
  resource_group_name  = azurerm_network_security_group.twdemonsg.resource_group_name
  virtual_network_name = azurerm_virtual_network.tw-vnet-prod.name
  address_prefix       = "10.0.1.0/24"
}
