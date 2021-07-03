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

output "private_key_pem" {
  description = "The private key data in PEM format"
  value       = module.dev-test-lab.private_key_pem
  sensitive   = true
}

output "public_key_pem" {
  description = "The public key data in PEM format"
  value       = module.dev-test-lab.public_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "The public key data in OpenSSH `authorized_keys` format, if the selected private key format is compatible. All RSA keys are supported, and `ECDSA` keys with curves `P256`, `P384` and `P521` are supported. This attribute is empty if an incompatible ECDSA curve is selected"
  value       = module.dev-test-lab.public_key_openssh
  sensitive   = true
}

output "admin_password" {
  description = "The Password associated with the `admin_username` used to login to this Virtual Machine"
  value       = module.dev-test-lab.admin_password
  sensitive   = true
}

output "dev_test_lab_linux_virtual_machine_id" {
  description = "The ID of the Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_linux_virtual_machine_id
}

output "dev_test_lab_linux_virtual_machine_fqdn" {
  description = "The FQDN of the Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_linux_virtual_machine_fqdn
}

output "dev_test_lab_linux_virtual_machine_unique_identifier" {
  description = "The unique immutable identifier of the Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_linux_virtual_machine_unique_identifier
}

output "dev_test_lab_windows_virtual_machine_id" {
  description = "The ID of the Windows Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_windows_virtual_machine_id
}

output "dev_test_lab_windows_virtual_machine_fqdn" {
  description = "The FQDN of the Windows Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_windows_virtual_machine_fqdn
}

output "dev_test_lab_windows_virtual_machine_unique_identifier" {
  description = "The unique immutable identifier of the Windows Virtual Machine"
  value       = module.dev-test-lab.dev_test_lab_windows_virtual_machine_unique_identifier
}
