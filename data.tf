data "azurerm_client_config" "current" {}

data "azuread_application" "key_vault" {
  name = "https://vault.azure.net"
}