provider "azurerm" {
  version = "~>2.0"
  features {}
}

module "naming" {
  source = "git@github.com:Azure/terraform-azurerm-naming"
  suffix = var.suffix
  prefix = var.prefix
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.storage_account.identity.0.principal_id

  key_permissions    = var.storage_key_permissions
  secret_permissions = []
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = var.client_key_permissions
  secret_permissions = []
}

resource "azurerm_key_vault_key" "storage_key" {
  name         = module.naming.key_vault_key.name
  key_vault_id = data.azurerm_key_vault.key_vault.id
  key_type     = var.key_type
  key_size     = var.key_length
  key_opts     = var.key_options

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage,
  ]
}

resource "azurerm_storage_account_customer_managed_key" "storage_key" {
  storage_account_id = var.storage_account.id
  key_vault_id       = data.azurerm_key_vault.key_vault.id
  key_name           = azurerm_key_vault_key.storage_key.name
  key_version        = azurerm_key_vault_key.storage_key.version
}
