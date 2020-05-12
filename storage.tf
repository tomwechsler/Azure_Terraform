provider "azurerm" {
    features {}
    }
resource "azurerm_storage_account" "lab" {
  name                     = "twstacc2020"
  resource_group_name      = "tw-rg02"
  location                 = "WestEurope"
  account_tier            = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "Terraform Storage"
    CreatedBy = "Admin"
      }
  }