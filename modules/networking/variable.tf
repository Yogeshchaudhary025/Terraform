variable "rg_name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Resource Location"
}

variable "vnet_name" {
    type = string
    description = "Virtual Network Name"
}

variable "vnet_address_space" {
  type = string
  description = "virtual network address space"
}

variable "subnet_name" {
    type = set(string)
    description = "subnet name"
}

variable "nsg-names"{
    type = map(string)
    description = "define as map of nsg name as key and subnet name as value"
}

variable "nsg-rules" {
   type = list
   description = "define list of nsg rules"
}

variable "bastian_required"{
    type = bool
    description = "Specify true if bastian is required"
    default = false
}