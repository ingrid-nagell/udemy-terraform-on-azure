

resource "azurerm_virtual_network" "avn" {
    name = local.virtual_network.name
    location = var.location
    resource_group_name = azurerm_resource_group.appgrp.name
    address_space = [local.virtual_network.address_space]
}

resource "azurerm_subnet" "appsubnet" {
    name = local.subnets[0].name
    resource_group_name = azurerm_resource_group.appgrp.name
    virtual_network_name = azurerm_virtual_network.avn.name
    address_prefixes = local.subnets[0].address_prefixes
}

resource "azurerm_subnet" "websubnet" {
    name = local.subnets[1].name
    resource_group_name = var.resource_group_name
    virtual_network_name = local.virtual_network.name
    address_prefixes = local.subnets[1].address_prefixes
    depends_on = [
        azurerm_virtual_network.avn
    ]
}

resource "azurerm_network_interface" "webnic" {
  name                = "web-nic"
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webip01.id
  }
}

resource "azurerm_public_ip" "webip01" {
  name                    = "web-ip"
  resource_group_name     = azurerm_resource_group.appgrp.name
  location                = var.location
  allocation_method       = "Static"
}

resource "azurerm_network_security_group" "appnsg" {
  name                = "app-nsg"
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
