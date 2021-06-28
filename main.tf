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


