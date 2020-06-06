provider "azurerm" {
  version = "~>2.0"
  features {}
}

locals {
  unique_name_stub = substr(module.naming.unique-seed, 0, 5)
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
}
resource "azurerm_resource_group" "test_group" {
  name     = "${module.naming.resource_group.slug}-${module.naming.storage_managed_encryption_key.slug}-min-test-${local.unique_name_stub}"
  location = "uksouth"
}

resource "azurerm_key_vault" "key_vault" {
  name                     = module.naming.key_vault.name
  location                 = azurerm_resource_group.test_group.location
  resource_group_name      = azurerm_resource_group.test_group.name
  tenant_id                = data.azurerm_subscription.current.tenant_id
  purge_protection_enabled = true
  soft_delete_enabled      = true
  sku_name                 = "standard"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.test_group.name
  location                 = azurerm_resource_group.test_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "terraform-azurerm-storage-managed-encryption-key" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test_group.name
  storage_account     = azurerm_storage_account.storage_account
  key_vault_name      = azurerm_key_vault.key_vault.name
}
