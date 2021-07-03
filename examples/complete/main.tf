module "dev-test-lab" {
  // source  = "kumarvna/dev-test-lab/azurerm"
  //version = "1.0.0"
  source = "../../"

  # By default, this module will create a resource group
  # proivde a name to use an existing resource group and set the argument 
  # to `create_resource_group = false` if you want to existing resoruce group. 
  # If you use existing resrouce group location will be the same as existing RG.
  create_resource_group = false
  resource_group_name   = "rg-shared-westeurope-01"
  location              = "westeurope"

  dev_test_lab_settings = {
    name                            = "mydemoproject1"
    storage_type                    = "Premium"
    use_public_ip_address           = "Allow"
    use_in_virtual_machine_creation = "Allow"
  }

  linux_virtual_machine = {
    vm-linux = {
      linux_distribution_name    = "ubuntu1804"
      virtual_machine_size       = "Standard_A2_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = false
    },
    vm-linux2 = {
      virtual_machine_size       = "Standard_A4_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = true
      gallery_image_reference = {
        publisher = "RedHat"
        offer     = "RHEL"
        sku       = "8"
        version   = "latest"
      }
    },
  }

  generate_admin_ssh_key = true
  #  admin_password         = "P@$$w0rd@1234!"
  #
  windows_virtual_machine = {
    win2019vm1 = {
      windows_distribution_name  = "windows2019dc"
      virtual_machine_size       = "Standard_A2_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = false
    },
    windesktop10vm1 = {
      virtual_machine_size       = "Standard_A2_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = false
      gallery_image_reference = {
        publisher = "MicrosoftWindowsDesktop"
        offer     = "Windows-10"
        sku       = "20h2-ent"
        version   = "latest"
      }
    }
  }

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
