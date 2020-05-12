provider "azurerm" {
features {}
}
resource"azurerm_resource_group" "rg" {
name="tw-rg02"
location ="westeurope"

tags = {
environment = "Terraform"
deployedby = "Admin"
 }
}