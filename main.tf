#------------------------------------------------------------
# Local configuration - Default (required). 
#------------------------------------------------------------

locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)

  linux_virtual_machine = defaults(var.linux_virtual_machine, {
    allow_claim                = true
    disallow_public_ip_address = false
  })
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  count               = var.use_custom_virtual_network ? 1 : 0
  name                = var.virtual_network_name
  resource_group_name = local.resource_group_name
}

data "azurerm_subnet" "snet" {
  count                = var.use_custom_virtual_network ? 1 : 0
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.0.name
  resource_group_name  = local.resource_group_name
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
  count               = var.use_custom_virtual_network == false ? 1 : 0
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


#---------------------------------------------------------------
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
#---------------------------------------------------------------
resource "tls_private_key" "rsa" {
  count     = var.generate_admin_ssh_key == true && var.admin_password == null ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

#-----------------------------------
# Random Resources
#-----------------------------------
resource "random_password" "passwd" {
  count       = var.generate_admin_ssh_key == false && var.admin_password == null ? 1 : 0
  length      = var.random_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false

  keepers = {
    password = var.linux_distribution_name
  }
}

resource "azurerm_dev_test_linux_virtual_machine" "main" {
  for_each                   = var.linux_virtual_machine != null ? { for k, v in var.linux_virtual_machine : k => v if v != null } : {}
  name                       = substr(each.key, 0, 62) # Charcter lengh for linux - 62 and windows - 15
  lab_name                   = azurerm_dev_test_lab.main.name
  resource_group_name        = local.resource_group_name
  location                   = local.location
  lab_virtual_network_id     = var.use_custom_virtual_network == true ? data.azurerm_virtual_network.vnet.0.id : azurerm_dev_test_virtual_network.main.0.id
  lab_subnet_name            = var.use_custom_virtual_network == true ? data.azurerm_subnet.snet.0.name : azurerm_dev_test_virtual_network.main.0.subnet[0].name
  size                       = each.value["virtual_machine_size"]
  storage_type               = each.value["storage_type"]
  allow_claim                = each.value["allow_claim"]
  username                   = each.value["admin_username"]
  password                   = var.generate_admin_ssh_key == false && var.admin_password == null ? element(concat(random_password.passwd.*.result, [""]), 0) : var.admin_password
  ssh_key                    = var.generate_admin_ssh_key == true ? tls_private_key.rsa.0.public_key_openssh : null
  disallow_public_ip_address = each.value["disallow_public_ip_address"]
  tags                       = merge({ "ResourceName" = each.key }, var.tags, )
  notes                      = each.value["virtual_machine_notes"]

  gallery_image_reference {
    publisher = each.value.gallery_image_reference != null ? each.value.gallery_image_reference["publisher"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
    offer     = each.value.gallery_image_reference != null ? each.value.gallery_image_reference["offer"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
    sku       = each.value.gallery_image_reference != null ? each.value.gallery_image_reference["sku"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
    version   = each.value.gallery_image_reference != null ? each.value.gallery_image_reference["version"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
  }
}

