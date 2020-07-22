data "azurerm_client_config" "current" {}

data "azuread_application" "key_vault" {
  application_id = var.key_vault_application_id
}