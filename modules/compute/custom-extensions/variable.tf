variable "rg_name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Resource Location"
}

variable "extension-name" {
  type = string
  description = "Extension Name"
}

variable "vm-id" {
  type = string
  description = "Extension Name"
}

variable "publisher" {
  type = string
  description = "Extension Name"
}

variable "extension-type" {
  type = string
  description = "Extension Name"
}

variable "handler-version" {
  type = string
  description = "Handler-version"
}

variable "storage_account_name" {
    type = string
}

variable "container_name" {
    type = string
}