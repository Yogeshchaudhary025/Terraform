#creating storage account
resource "azurerm_storage_account" "storage-account" {
  count = var.storage-account-already-exist ? 0 : 1
  name                     = var.storage-account-name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#creating storage account containers
resource "azurerm_storage_container" "storage-conatiner" {
  name                  = var.container-name
  storage_account_name  = var.storage-account-name
  container_access_type = var.container-access
  depends_on = [ azurerm_storage_account.storage-account[0] ]
}



#uploading blobs -updating the values of scripts content by specifying variable values

resource "azurerm_storage_blob" "blobs" {
    for_each = {for k,v in var.blobs : k => v if var.blobs-enabled}
  name                   = each.key
  storage_account_name   = var.storage-account-name
  storage_container_name = azurerm_storage_container.storage-conatiner.name
  type                   = "Block"
  source_content         =  templatefile("${each.value}${each.key}",{storage-account-name = var.storage-account-name,container-name = var.container-name,app-container-name = var.app-container-name})
  depends_on = [ azurerm_storage_container.storage-conatiner ]
}


#upload blobs as they are in binary format
resource "azurerm_storage_blob" "blobs_binary" {
    for_each = {for k,v in var.blobs-binary : k => v if var.blobs-binary-enabled}
  name                   = each.key
  storage_account_name   = var.storage-account-name
  storage_container_name = azurerm_storage_container.storage-conatiner.name
  type                   = "Block"
  source                 =  "${each.value}${each.key}"
  depends_on = [ azurerm_storage_container.storage-conatiner ]
}