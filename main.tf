
#creating resource group 

module "general" {
  source = "./modules/general"
  rg_name = local.rg_name
  location = local.location
}

#creating virtual network, subnets and azure bastian (optional)

module "networking" {
  source = "./modules/networking"
  rg_name = local.rg_name
  location = local.location
  vnet_name = "staging-network"
  vnet_address_space = "10.0.0.0/16"
  subnet_name = [ "web-subnet","db-subnet" ]
  bastian_required = true
  nsg-names = {
    web-nsg = "web-subnet"
    db-nsg = "db-subnet"
  }
  nsg-rules = [{
      id=1,
      priority="200",
      network_security_group_name="web-nsg"
      destination_port_range="3389"
      access="Allow"
  },
  {
      id=2,
      priority="300",
      network_security_group_name="web-nsg"
      destination_port_range="80"
      access="Allow"
  },
  {
      id=3,
      priority="400",
      network_security_group_name="web-nsg"
      destination_port_range="8172"
      access="Allow"
  },
  {
      id=4,
      priority="200",
      network_security_group_name="db-nsg"
      destination_port_range="3389"
      access="Allow"
  }
  ]
}

#creating db virtual machine
module "compute" {
   source = "./modules/compute"
   rg_name = local.rg_name
   location = local.location
   nic-name = "db-nic"
   subnets-id = module.networking.subnet_output["db-subnet"].id
   depends_on = [ module.networking ]
   vm-name = "database-vm"
   admin-username = "adminuser"
   admin-password = "Password@123"
   source-image-reference = {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2019-ws2019"
    sku       = "sqldev"
    version   = "15.0.220510"
  } 
}


resource "azurerm_mssql_virtual_machine" "mmsql-db" {
  virtual_machine_id               = module.compute.vm_output.id
  sql_license_type                 = "PAYG"
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "Password@123"
  sql_connectivity_update_username = "adminuser"
}