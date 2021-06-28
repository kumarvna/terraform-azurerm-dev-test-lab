output "dev_test_lab_id" {
  description = "The resource ID of the Dev Test Lab"
  value       = azurerm_dev_test_lab.main.id
}

output "artifacts_storage_account_id" {
  description = "The ID of the Storage Account used for Artifact Storage"
  value       = azurerm_dev_test_lab.main.artifacts_storage_account_id
}

output "default_storage_account_id" {
  description = "The ID of the Default Storage Account for this Dev Test Lab"
  value       = azurerm_dev_test_lab.main.default_storage_account_id
}

output "default_premium_storage_account_id" {
  description = "The ID of the Default Premium Storage Account for this Dev Test Lab"
  value       = azurerm_dev_test_lab.main.default_premium_storage_account_id
}

output "key_vault_id" {
  description = "The ID of the Key used for this Dev Test Lab"
  value       = azurerm_dev_test_lab.main.key_vault_id
}

output "premium_data_disk_storage_account_id" {
  description = "The ID of the Storage Account used for Storage of Premium Data Disk"
  value       = azurerm_dev_test_lab.main.premium_data_disk_storage_account_id
}

output "dev_test_lab_unique_identifier" {
  description = "The unique immutable identifier of the Dev Test Lab"
  value       = azurerm_dev_test_lab.main.unique_identifier
}

output "dev_test_lab_virtual_network_id" {
  description = "The ID of the Dev Test Virtual Network"
  value       = azurerm_dev_test_virtual_network.main.id
}

output "dev_test_lab_subnet_name" {
  description = "The name of the Subnet for this Virtual Network."
  value       = azurerm_dev_test_virtual_network.main.subnet[0].name
}

output "dev_test_lab_virtual_network_unique_identifier" {
  description = "The unique immutable identifier of the Dev Test Virtual Network"
  value       = azurerm_dev_test_virtual_network.main.unique_identifier
}
