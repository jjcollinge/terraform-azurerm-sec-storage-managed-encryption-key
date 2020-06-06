output "storage_managed_key" {
  value       = module.terraform-azurerm-storage-managed-encryption-key
  description = "The customer managed key associated with Storage Account Encryption."
}
