output "storage_managed_key" {
  value       = azurerm_storage_account_customer_managed_key.storage_key
  description = "The customer managed key associated with Storage Account Encryption."
}
