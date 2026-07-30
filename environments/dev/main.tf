module "rg" {
  source  = "../../modules/azure_resource_group"
  rgnames = var.rg_map
}

module "stg" {
  depends_on = [module.rg]
  source     = "../../modules/azure_storage_account"
  stgnames   = var.stg_map
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/azure_virtual_network"
  vnetnames  = var.vnet_map
}

module "subnet" {
  depends_on  = [module.vnet]
  source      = "../../modules/azure_subnet"
  subnetnames = var.subnet_map
}