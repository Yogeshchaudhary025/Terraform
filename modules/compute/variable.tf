variable "rg_name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Resource Location"
}

variable "nic-name" {
    type = string
    description = "Network Interface name"
}

variable "subnets-id" {
    type = string
    description = "Subnets id information"
}

variable "publicIpRequired" {
    type = bool
    default = false
    description = "Specify whether public Ip is required or not"
}

variable "vm-name" {
  type = string
  description = "virtual machine name"
}

variable "admin-username" {
  type = string
  description = "Specify Admin Username"
}

variable "admin-password" {
  type = string
  description = "Specify Admin Password"
}

variable "source-image-reference" {
    type = map(string)
   description = "Source Image Reference"
}