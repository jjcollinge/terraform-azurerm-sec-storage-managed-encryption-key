#Required variables

#Passing the storage account object to account for missing attribute field returned from data azurerm_storage_account
variable "storage_account" {
  type        = any
  description = "The Storage Account to apply the Managed Encryption Key to."
}

variable "key_vault_id" {
  type        = string
  description = "The Key Vault to store the Managed Encryption Key in."
}

#Optional variables
variable "prefix" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "client_key_permissions" {
  type        = list(string)
  description = "A list of client key permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = ["get", "delete", "list", "purge", "sign", "verify", "create", "unwrapkey", "wrapkey", "update"]
}

variable "client_secret_permissions" {
  type        = list(string)
  description = "A list of client secret permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = []
}

variable "client_storage_permissions" {
  type        = list(string)
  description = "A list of client storage permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "storage_key_permissions" {
  type        = list(string)
  description = "A list of storage key permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = ["get", "delete", "list", "purge", "sign", "verify", "create", "unwrapkey", "wrapkey", "update"]
}

variable "storage_secret_permissions" {
  type        = list(string)
  description = "A list of storage key permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = []
}

variable "storage_storage_permissions" {
  type        = list(string)
  description = "A list of storage storage permissions associated with the newly generated key."
  #Provide these permissions by default to allow for the creation of a new managed encryption key by key vault
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "key_type" {
  type        = string
  description = "The key type of the key that Azure Key Vault will generate."
  default     = "RSA"
}

variable "key_length" {
  type        = string
  description = "The key length of the key that Azure Key Vault will generate."
  default     = 4096
}

variable "key_options" {
  type        = list(string)
  description = "The key options of the key that Azure Key Vault will generate."
  default     = []
}

variable "key_vault_object_id" {
  type        = string
  description = "The AAD object ID used by Azure Key Vault. See: https://docs.microsoft.com/en-us/azure/key-vault/secrets/overview-storage-keys#service-principal-application-id"
  default     = "93c27d83-f79b-4cb2-8dd4-4aa716542e74" # For Azure Government use cdf90028-ceee-4d20-b0a3-f1c4ac357e66
}