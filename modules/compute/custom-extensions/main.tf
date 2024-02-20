resource "azurerm_virtual_machine_extension" "vm_script_extension" {
  name                 = var.extension-name
  virtual_machine_id   = var.vm-id
  publisher            = var.publisher
  type                 = var.extension-type
  type_handler_version = var.handler-version

  settings = <<SETTINGS
    {
        "fileUris": ["https://${var.storage_account_name}.blob.core.windows.net/${var.container_name}/Script.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file Script.ps1"     
    }
SETTINGS
}