module "dev-test-lab" {
  source  = "kumarvna/dev-test-lab/azurerm"
  version = "1.0.0"

  # By default, this module will create a resource group
  # proivde a name to use an existing resource group and set the argument 
  # to `create_resource_group = false` if you want to existing resoruce group. 
  # If you use existing resrouce group location will be the same as existing RG.
  resource_group_name = "rg-shared-westeurope-02"
  location            = "westeurope"

  # Dev Test Labs specification
  dev_test_lab_settings = {
    name                            = "mydemoproject1"
    storage_type                    = "Premium"
    use_public_ip_address           = "Allow"
    use_in_virtual_machine_creation = "Allow"
  }

  # This module support multiple Pre-Defined Windows Distributions.
  # Windows Images: windows2012r2dc, windows2016dc, windows2019dc, windows2016dccore
  # MSSQL 2017 images: mssql2017exp, mssql2017dev, mssql2017std, mssql2017ent
  # MSSQL 2019 images: mssql2019dev, mssql2019std, mssql2019ent
  # To use  Gallery Image, specify `gallery_image_reference` block 
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

  # This module support multiple Pre-Defined Linux Distributions.
  # Linux images: ubuntu1804, ubuntu1604, centos75, centos77, centos81, coreos
  # MSSQL 2019 Linux OS Images:
  # RHEL8 images: mssql2019ent-rhel8, mssql2019std-rhel8, mssql2019dev-rhel8
  # Ubuntu images: mssql2019ent-ubuntu1804, mssql2019std-ubuntu1804, mssql2019dev-ubuntu1804
  # To use  Gallery Image, specify `gallery_image_reference` block 
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

  # Generates a secure private key for Linux Servers - Recomended for Test VM's only.
  # By default this module generates ssh key pair for linux servers. 
  # To specify custom password, set `generate_admin_ssh_key = false` and set  `admin_password`
  # To specify own ssh key, use `admin_ssh_key_data` argument with valid key file path. 
  generate_admin_ssh_key = true
  #  admin_password         = "P@$$w0rd@1234!"

  # Adding TAG's to your Azure resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
