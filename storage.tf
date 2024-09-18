
resource "azurerm_storage_account" "storageaccount_train" {
    name = "storagetrain232324322"
    resource_group_name = var.resource_group_name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    depends_on = [
      azurerm_resource_group.appgrp
    ]
}

resource "azurerm_storage_container" "storagecontainertrain" {
  name = "storagecontainertrain"
  storage_account_name = "storagetrain232324322"
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.storageaccount_train
  ]
}

resource "azurerm_storage_blob" "blob_train" {
  name = "main.tf"
  storage_account_name = "storagetrain232324322"
  storage_container_name = "storagecontainertrain"
  type = "Block"
  source = "main.tf"
  depends_on = [
    azurerm_storage_container.storagecontainertrain
  ]
}
