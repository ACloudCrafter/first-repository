data "azurerm_subnet" "data_frontend_subnet" {    #Used Data block for subnet -> will be removed while using Bastion
  name                 = "frontend-subnet"
  virtual_network_name = "first-vnet"
  resource_group_name  = "first-rg"
}

# data "azurerm_key_vault" "kv" {
#   name                = "firstpassword"
#   resource_group_name = "first-rg"
# }

# data "azurerm_key_vault_secret" "username" {
#   name         = "frontendvmusername"                   #secret ka naam as on portal
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "password" {
#   name         = "frontendvmpassword"                   #secret ka naam as on portal
#   key_vault_id = data.azurerm_key_vault.kv.id
# }