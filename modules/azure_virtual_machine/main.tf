#Manually create Publicip -> NIC -> VM
# resource "azurerm_public_ip" "pip" {
#   name                    = "first-pip"
#   location                = "centralindia"
#   resource_group_name     = "first-rg"
#   allocation_method       = "Static"
#   idle_timeout_in_minutes = 30
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "first-nic"
#   location            = "centralindia"
#   resource_group_name = "first-rg"

#   ip_configuration {
#     name                          = "first-ipconfig"
#     subnet_id                     = "/subscriptions/329f8580-e5e1-43d2-9d07-f54e5353bc5b/resourceGroups/first-rg/providers/Microsoft.Network/virtualNetworks/first-vnet/subnets/frontend-subnet"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip.id
#   }
# }

# resource "azurerm_linux_virtual_machine" "vm" {
#   name                            = "first-vm"
#   resource_group_name             = "first-rg"
#   location                        = "centralindia"
#   size                            = "Standard_D4_v5"
#   admin_username                  = "adminuser"
#   admin_password                  = "Password@123"
#   disable_password_authentication = false
#   network_interface_ids           = [azurerm_network_interface.nic.id]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }


#Automation se Publicip -> NIC -> VM

# resource "azurerm_public_ip" "pip" {
#   name                    = "first-pip"
#   location                = "centralindia"
#   resource_group_name     = "first-rg"
#   allocation_method       = "Static"
#   idle_timeout_in_minutes = 30
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "first-nic"
#   location            = "centralindia"
#   resource_group_name = "first-rg"

#   ip_configuration {
#     name                          = "first-ipconfig"
#     subnet_id                     = data.azurerm_subnet.data_frontend_subnet.id   #used from data block
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip.id
#   }
# }

# resource "azurerm_linux_virtual_machine" "vm" {
#   name                            = "first-vm"
#   resource_group_name             = "first-rg"
#   location                        = "centralindia"
#   size                            = "Standard_D4_v5"
#   admin_username                  = "adminuser"
#   admin_password                  = "Password@123"
#   disable_password_authentication = false
#   network_interface_ids           = [azurerm_network_interface.nic.id]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }


#for_each se VM -> Public IP nahi chahiye as Bastion used

data "azurerm_subnet" "subnet" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "first-ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id #used from data block
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  #   admin_username                  = data.azurerm_key_vault_secret.username.value
  #   admin_password                  = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
