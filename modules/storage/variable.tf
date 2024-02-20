variable "rg_name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Resource Location"
}

variable "storage-account-name" {
  type = string
  description = "Storage account name"
}

variable "container-name" {
  type = string
  description = "Container name"
}

variable "container-access"{
  type = string
  description = "container access type"
}

variable "app-container-name"{
  type = string
  description = "application container name"
  default = "default"
}

variable "blobs" {
    type = map(string)
    description = "details of blobs to be uploaded"
    default = {
      "" = ""
    }
  
}

variable "blobs-binary" {
    type = map(string)
    description = "details of blobs to be uploaded"
    default = {
      "" = ""
    }
  
}

variable "blobs-enabled" {
  type =bool
  default = false
   description = "mark it as true if you want to upload blob by trasforming them via source file"
}

variable "blobs-binary-enabled" {
  type =bool
  default = false
  description = "mark it as true if you want to upload as they are in binary format"
}

variable "storage-account-already-exist" {
  type =bool
  default = false
  description = "mark the value as true if sorage account already exist, false by default"
}