resource "azurerm_resource_group" "rgs" {
  for_each = var.rgnames
  name = each.value.name
  location = each.value.location
}