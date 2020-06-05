data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "base" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.base.name
}

