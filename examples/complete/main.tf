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

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
