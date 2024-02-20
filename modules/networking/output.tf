output "subnet_output" {
  value = azurerm_subnet.subnets
}

output "v-net_output"{
    value = azurerm_virtual_network.v-net
}

output "nsg_output"{
    value = azurerm_network_security_group.web-nsg
}