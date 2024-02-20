#creating network interface 

resource "azurerm_network_interface" "web-nic" {
  name                = "web-nic"
  location            = local.location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = "web-ip"
    subnet_id                     = module.networking.subnet_output["web-subnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web-publicIP.id
  }
  depends_on = [module.general.rg_output,module.networking.subnet_output,azurerm_public_ip.web-publicIP]
}

#creating public Ip for vm
resource "azurerm_public_ip" "web-publicIP" {
  name                = "web-publicIP"
  resource_group_name = local.rg_name
  location            = local.location
  allocation_method   = "Static"
  
  depends_on = [module.general.rg_output ]
}


#creating virtual machine

resource "azurerm_windows_virtual_machine" "web-vm" {
  name                = "web-vm"
  resource_group_name = local.rg_name
  location            = local.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  network_interface_ids = [azurerm_network_interface.web-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

    depends_on = [
    azurerm_network_interface.web-nic,
    module.general.rg_output
  ]
}