provider "azurerm" {
    features {}
    }

resource "azurerm_resource_group" "terraform-rg" {
  name     = "tw-terraform-rg2020"
  location = "West Europe"
}

resource "azurerm_network_security_group" "terraform-rg" {
  name                = "tw-terraform-SecurityGroup1"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
}

resource "azurerm_network_ddos_protection_plan" "terraform-rg" {
  name                = "tw-ddospplan1"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
}

resource "azurerm_virtual_network" "terraform-rg" {
  name                = "tw-vnet-prod"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.terraform-rg.id
    enable = true
  }

  subnet {
    name           = "Prod"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "DevOps"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "SIEM"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.terraform-rg.id
  }

  tags = {
    environment = "Production"
  }
}
