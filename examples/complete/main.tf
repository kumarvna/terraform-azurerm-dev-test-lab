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
  /*
  virtual_machine_name       = "vm-linux"
  os_flavor                  = "linux"
  linux_distribution_name    = "ubuntu1804"
  virtual_machine_size       = "Standard_A2_v2"
  generate_admin_ssh_key     = false
  admin_ssh_key_data         = "~/.ssh/id_rsa.pub"
  instances_count            = 2
  disallow_public_ip_address = false
*/
  linux_virtual_machine = {
    vm-linux = {
      linux_distribution_name    = "ubuntu1804"
      virtual_machine_size       = "Standard_A2_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = false
    },
    vm-linux2 = {
      linux_distribution_name    = "centos75"
      virtual_machine_size       = "Standard_A4_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = true
    },
    vm-linux3 = {
      linux_distribution_name    = "centos81"
      virtual_machine_size       = "Standard_A4_v2"
      admin_username             = "azureadmin"
      storage_type               = "Premium"
      disallow_public_ip_address = true
    },
  }
  generate_admin_ssh_key = true
  #  admin_password         = "P@$$w0rd@1234!"
  #

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
