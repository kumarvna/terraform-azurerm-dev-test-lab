#------------------------------------------------------------
# Local configuration - Default (required). 
#------------------------------------------------------------

locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}

resource "azurerm_dev_test_lab" "main" {
  name                = format("%s", var.dev_test_lab_settings.name)
  resource_group_name = local.resource_group_name
  location            = local.location
  storage_type        = var.dev_test_lab_settings.storage_type
  tags                = merge({ "Name" = format("%s", var.dev_test_lab_settings.name) }, var.tags, )
}

resource "azurerm_dev_test_virtual_network" "main" {
  name                = format("%s-network", var.dev_test_lab_settings.name)
  resource_group_name = local.resource_group_name
  lab_name            = azurerm_dev_test_lab.main.name
  description         = var.dev_test_lab_settings.description
  subnet {
    use_public_ip_address           = var.dev_test_lab_settings.use_public_ip_address
    use_in_virtual_machine_creation = var.dev_test_lab_settings.use_in_virtual_machine_creation
  }
  tags = merge({ "Name" = format("%s-network", var.dev_test_lab_settings.name) }, var.tags, )
}

/*
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id = azurerm_dev_test_lab.main.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_dev_test_lab.main.unique_identifier #data.azurerm_client_config.current.object_id
  #application_id = azurerm_dev_test_lab.main.unique_identifier #"VSDevTestLab"

  key_permissions = [
    "create",
    "get",
    "purge",
    "recover"
  ]
}

resource "azurerm_key_vault_key" "main" {
  name         = format("%s-key", var.dev_test_lab_settings.name)
  key_vault_id = azurerm_dev_test_lab.main.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
*/

#---------------------------------------------------------------
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
#---------------------------------------------------------------
resource "tls_private_key" "rsa" {
  count     = var.generate_admin_ssh_key == true && var.os_flavor == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

#-----------------------------------
# Random Resources
#-----------------------------------
resource "random_password" "passwd" {
  count       = var.admin_password == null ? 1 : 0
  length      = var.random_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false

  keepers = {
    admin_password = var.os_flavor
  }
}


resource "azurerm_dev_test_linux_virtual_machine" "main" {
  count                      = var.os_flavor == "linux" ? var.instances_count : 0
  name                       = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)
  lab_name                   = azurerm_dev_test_lab.main.name
  resource_group_name        = local.resource_group_name
  location                   = local.location
  lab_virtual_network_id     = azurerm_dev_test_virtual_network.main.id
  lab_subnet_name            = azurerm_dev_test_virtual_network.main.subnet[0].name
  size                       = var.virtual_machine_size
  storage_type               = var.storage_type
  allow_claim                = var.allow_claim
  username                   = var.admin_username
  password                   = var.generate_admin_ssh_key != true && var.admin_password == null ? element(concat(random_password.passwd.*.result, [""]), 0) : var.admin_password
  ssh_key                    = var.generate_admin_ssh_key == true && var.os_flavor == "linux" ? tls_private_key.rsa[0].public_key_openssh : file(var.admin_ssh_key_data)
  disallow_public_ip_address = var.disallow_public_ip_address
  tags                       = merge({ "ResourceName" = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1) }, var.tags, )
  notes                      = var.virtual_machine_notes

  gallery_image_reference {
    publisher = var.gallery_image_reference != null ? var.gallery_image_reference["publisher"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
    offer     = var.gallery_image_reference != null ? var.gallery_image_reference["offer"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
    sku       = var.gallery_image_reference != null ? var.gallery_image_reference["sku"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
    version   = var.gallery_image_reference != null ? var.gallery_image_reference["version"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
  }
}

