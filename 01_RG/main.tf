provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "tw-demo-tf-rg"
  location = "West Europe"
  tags = {
    Projekt = "Cloud2020"
  }
}

#https://www.terraform.io/docs/providers/azurerm/index.html

#https://github.com/terraform-providers/terraform-provider-azurerm/releases
