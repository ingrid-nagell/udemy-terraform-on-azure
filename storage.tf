
resource "azurerm_storage_account" "storageaccount_train" {
    name = "storagetrain232324322"
    resource_group_name = azurerm_resource_group.appgrp.name
    location = azurerm_resource_group.appgrp.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    depends_on = [
      azurerm_resource_group.appgrp
    ]
}

resource "azurerm_storage_container" "storagecontainertrain" {
  name = "storagecontainertrain"
  storage_account_name = azurerm_storage_account.storageaccount_train.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob_train" {
  name = "main.tf"
  storage_account_name = azurerm_storage_account.storageaccount_train.name
  storage_container_name = azurerm_storage_container.storagecontainertrain.name
  type = "Block"
  source = "main.tf"
}
