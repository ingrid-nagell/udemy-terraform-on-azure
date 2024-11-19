

resource "azurerm_virtual_network" "avn" {
    name = local.virtual_network.name
    location = local.location
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
    resource_group_name = azurerm_resource_group.appgrp.name
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
  location                = local.location
  allocation_method       = "Static"
}

resource "azurerm_network_security_group" "app_nsg" {
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

resource "azurerm_network_security_group_association" "app_nsg_association" {
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_windows_virtual_machine" "webvm" {
  name                = "web-vm"
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = "123"
  network_interface_ids = [
    azurerm_network_interface.webnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "datadisk01" {
  name                 = "datadisk01"
  location             = azurerm_resource_group.appgrp.location
  resource_group_name  = azurerm_resource_group.appgrp.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "4"
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_webvm" {
  managed_disk_id    = azurerm_managed_disk.datadisk01.id
  virtual_machine_id = azurerm_windows_virtual_machine.webvm.id
  lun                = "10"
  caching            = "ReadWrite"
}
