resource "azurerm_network_interface" "vm-nic" {
  name                = var.nic-name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnets-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = try(azurerm_public_ip.vm-PublicIP[0].id,null)
  }
  depends_on = [ azurerm_public_ip.vm-PublicIP ]
}



resource "azurerm_public_ip" "vm-PublicIP" {
    count = var.publicIpRequired ? 1 : 0
  name                = "vm-public-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm-name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin-username
  admin_password      = var.admin-password
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source-image-reference.publisher
    offer     = var.source-image-reference.offer
    sku       = var.source-image-reference.sku
    version   = var.source-image-reference.version
  }
  depends_on = [ azurerm_network_interface.vm-nic ]
}