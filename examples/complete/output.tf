output "dev_test_lab_id" {
  description = "The resource ID of the Dev Test Lab"
  value       = module.dev-test-lab.dev_test_lab_id
}

output "artifacts_storage_account_id" {
  description = "The ID of the Storage Account used for Artifact Storage"
  value       = module.dev-test-lab.artifacts_storage_account_id
}

output "default_storage_account_id" {
  description = "The ID of the Default Storage Account for this Dev Test Lab"
  value       = module.dev-test-lab.default_storage_account_id
}

output "default_premium_storage_account_id" {
  description = "The ID of the Default Premium Storage Account for this Dev Test Lab"
  value       = module.dev-test-lab.default_premium_storage_account_id
}

output "key_vault_id" {
  description = "The ID of the Key used for this Dev Test Lab"
  value       = module.dev-test-lab.key_vault_id
}

output "premium_data_disk_storage_account_id" {
  description = "The ID of the Storage Account used for Storage of Premium Data Disk"
  value       = module.dev-test-lab.premium_data_disk_storage_account_id
}

output "dev_test_lab_unique_identifier" {
  description = "The unique immutable identifier of the Dev Test Lab"
  value       = module.dev-test-lab.dev_test_lab_unique_identifier
}

output "dev_test_lab_virtual_network_id" {
  description = "The ID of the Dev Test Virtual Network"
  value       = module.dev-test-lab.dev_test_lab_virtual_network_id
}

output "dev_test_lab_subnet_name" {
  description = "The name of the Subnet for this Virtual Network."
  value       = module.dev-test-lab.dev_test_lab_subnet_name
}

output "dev_test_lab_virtual_network_unique_identifier" {
  description = "The unique immutable identifier of the Dev Test Virtual Network"
  value       = module.dev-test-lab.dev_test_lab_virtual_network_unique_identifier
}
