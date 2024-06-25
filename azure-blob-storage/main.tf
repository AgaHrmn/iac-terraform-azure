resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "asa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "asc" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.asa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob" {
  name                   = var.storage_blob_name
  storage_account_name   = azurerm_storage_account.asa.name
  storage_container_name = azurerm_storage_container.asc.name
  type                   = "Block"
  source                 = var.storage_blob_source_path
}
