rg_map = {
  rg-1 = {
    name     = "first-rg"
    location = "centralindia"
  }
  rg-2 = {
    name     = "second-rg"
    location = "malaysiawest"
  }
}

stg_map = {
  stg-1 = {
    name                     = "firststorageis1"
    location                 = "centralindia"
    resource_group_name      = "first-rg"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  stg-2 = {
    name                     = "secondstorageis2"
    location                 = "malaysiawest"
    resource_group_name      = "second-rg"
    account_tier             = "Standard"
    account_replication_type = "ZRS"
  }
}

vnet_map = {
  vnet-1 = {
    name                = "first-vnet"
    location            = "centralindia"
    resource_group_name = "first-rg"
    address_space       = ["10.0.0.0/16"]
  }
  vnet-2 = {
    name                = "second-vnet"
    location            = "malaysiawest"
    resource_group_name = "second-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet_map = {
  subnet-1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "first-rg"
    virtual_network_name = "first-vnet"
    address_prefixes     = ["10.0.0.0/24"]
  }
  subnet-2 = {
    name                 = "backend-subnet"
    resource_group_name  = "second-rg"
    virtual_network_name = "second-vnet"
    address_prefixes     = ["10.0.0.0/20"]
  }
}