#including resource group module

module "resource_group" {
    source = ".././general"
    rg_name = var.rg_name
    location =  var.location
}

# creating virtual network resources

resource "azurerm_virtual_network" "v-net" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address_space]
  depends_on = [ module.resource_group ]
}

# creating virtual network subnets

resource "azurerm_subnet" "subnets" {
    for_each = var.subnet_name
  name                 = each.key
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [cidrsubnet(var.vnet_address_space,8,index(tolist(var.subnet_name),each.key))]
  depends_on = [ azurerm_virtual_network.v-net ]
  }

#creating nsg & nsg-rules

resource "azurerm_network_security_group" "web-nsg" {
      for_each = var.nsg-names
  name                 = each.key
  location            = var.location
  resource_group_name = var.rg_name
  depends_on = [ module.resource_group ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet-link" {
    for_each = var.nsg-names
  subnet_id                 = azurerm_subnet.subnets[each.value].id
  network_security_group_id = azurerm_network_security_group.web-nsg[each.key].id
  depends_on = [ azurerm_subnet.subnets,azurerm_network_security_group.web-nsg ]
}


resource "azurerm_network_security_rule" "network-security-group-rules" {
    for_each = {for rule in var.nsg-rules: rule.id => rule }
  name                        = "${each.value.access}-${each.value.destination_port_range}"
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = each.value.access
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.web-nsg[each.value.network_security_group_name].name
  depends_on = [ azurerm_network_security_group.web-nsg ]
}


# creating azure bastian resources

resource "azurerm_subnet" "bastian_subnet" {
    count = var.bastian_required ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.10.0/24"]
  depends_on = [ azurerm_virtual_network.v-net ]
}

resource "azurerm_public_ip" "bastian_publicIP" {
    count = var.bastian_required ? 1 : 0
  name                = "bastian_ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [ module.resource_group ]
}

resource "azurerm_bastion_host" "bastian_host" {
    count = var.bastian_required ? 1 : 0
  name                = "app-bastion"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "bastian-ip-configuration"
    subnet_id            = azurerm_subnet.bastian_subnet[0].id
    public_ip_address_id = azurerm_public_ip.bastian_publicIP[0].id
  }
    depends_on = [ azurerm_subnet.bastian_subnet, azurerm_virtual_network.v-net,azurerm_public_ip.bastian_publicIP ]
}

