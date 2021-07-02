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
  value       = azurerm_dev_test_virtual_network.main.0.id
}

output "dev_test_lab_subnet_name" {
  description = "The name of the Subnet for this Virtual Network."
  value       = azurerm_dev_test_virtual_network.main.0.subnet[0].name
}

output "dev_test_lab_virtual_network_unique_identifier" {
  description = "The unique immutable identifier of the Dev Test Virtual Network"
  value       = azurerm_dev_test_virtual_network.main.0.unique_identifier
}

output "private_key_pem" {
  description = "The private key data in PEM format"
  value       = tls_private_key.rsa.0.private_key_pem
  sensitive   = true
}

output "public_key_pem" {
  description = "The public key data in PEM format"
  value       = tls_private_key.rsa.0.public_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "The public key data in OpenSSH `authorized_keys` format, if the selected private key format is compatible. All RSA keys are supported, and `ECDSA` keys with curves `P256`, `P384` and `P521` are supported. This attribute is empty if an incompatible ECDSA curve is selected"
  value       = tls_private_key.rsa.0.public_key_openssh
  sensitive   = true
}

output "admin_password" {
  description = "The Password associated with the `admin_username` used to login to this Virtual Machine"
  value       = var.generate_admin_ssh_key == false && var.admin_password == null ? element(concat(random_password.passwd.*.result, [""]), 0) : var.admin_password
  sensitive   = true
}

output "dev_test_lab_linux_virtual_machine_id" {
  description = "The ID of the Virtual Machine"
  value       = { for k, v in azurerm_dev_test_linux_virtual_machine.main : k => v.id }
}

output "dev_test_lab_linux_virtual_machine_fqdn" {
  description = "The FQDN of the Virtual Machine"
  value       = { for k, v in azurerm_dev_test_linux_virtual_machine.main : k => v.fqdn }
}

output "dev_test_lab_linux_virtual_machine_unique_identifier" {
  description = "The unique immutable identifier of the Virtual Machine"
  value       = { for k, v in azurerm_dev_test_linux_virtual_machine.main : k => v.unique_identifier }
}
