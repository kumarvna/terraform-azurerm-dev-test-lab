variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = true
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "dev_test_lab_settings" {
  description = "Specifies the arguments for dev test lab creation"
  type = object({
    name                            = string
    storage_type                    = optional(string)
    description                     = optional(string)
    use_public_ip_address           = string
    use_in_virtual_machine_creation = string
  })
}

