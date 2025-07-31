module "resource_group1" {
  for_each                = var.resource_group
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = each.value.resource_group_name
  resource_group_location = each.value.resource_group_location
}

module "virtual_network1" {
  for_each                 = var.virtual_network
  depends_on               = [module.resource_group1]
  source                   = "../modules/azurerm_virtual_network"
  virtual_network_name     = each.value.virtual_network_name
  virtual_network_location = each.value.virtual_network_location
  resource_group_name      = each.value.resource_group_name
  address_space            = each.value.address_space
}

module "frontend_subnet1" {
  for_each             = var.frontend_subnet
  depends_on           = [module.virtual_network1, module.resource_group1]
  source               = "../modules/azurerm_subnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  subnet_name          = each.value.subnet_name
  address_prefixes     = each.value.address_prefixes
}

module "public_ip_frontend1" {
  depends_on          = [module.resource_group1]
  for_each            = var.public_ip_frontend
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
}

module "key_vault1" {
  depends_on          = [module.resource_group1]
  for_each            = var.key_vault
  source              = "../modules/azurerm_key_vault"
  key_vault_name      = each.value.key_vault_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

module "vm_username1" {
  for_each            = var.username
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault1]
  key_vault_name      = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
  secret_name         = each.value.secret_name
  secret_value        = each.value.secret_value
}

module "vm_password1" {
  for_each            = var.vm_password
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault1]
  key_vault_name      = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
  secret_name         = each.value.secret_name
  secret_value        = each.value.secret_value
}

module "frontend_vm1" {
  for_each   = var.frontend_vm
  depends_on = [module.frontend_subnet1, module.key_vault1, module.vm_username1, module.vm_password1, module.public_ip_frontend1]
  source     = "../modules/azurerm_virtual_machine"

  resource_group_name  = each.value.resource_group_name
  location             = each.value.location
  vm_name              = each.value.vm_name
  vm_size              = each.value.vm_size
  image_publisher      = each.value.image_publisher
  image_offer          = each.value.image_offer
  image_sku            = each.value.image_sku
  image_version        = each.value.image_version
  nic_name             = each.value.nic_name
  frontend_ip_name     = each.value.frontend_ip_name
  vnet_name            = each.value.vnet_name
  frontend_subnet_name = each.value.frontend_subnet_name
  key_vault_name       = each.value.key_vault_name
  username_secret_name = each.value.username_secret_name
  password_secret_name = each.value.password_secret_name
}


module "sql_server1" {
  depends_on                   = [module.resource_group1]
  for_each                     = var.sql_server
  source                       = "../modules/azurerm_sql_server"
  sql_server_name              = each.value.sql_server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}


module "sql_database1" {
  for_each            = var.sql_database
  depends_on          = [module.sql_server1]
  source              = "../modules/azurerm_sql_database"
  sql_server_name     = each.value.sql_server_name
  resource_group_name = each.value.resource_group_name
  sql_database_name   = each.value.sql_database_name
}



