resource_group = {
  RG1 = {
    resource_group_name     = "rg-jeet"
    resource_group_location = "centralindia"
  }
}

virtual_network = {
  Vnet1 = {
    virtual_network_name     = "vnet-todoapp"
    virtual_network_location = "centralindia"
    resource_group_name      = "rg-jeet"
    address_space            = ["10.0.0.0/16"]
  }
}

frontend_subnet = {
  subnet1 = {
    resource_group_name  = "rg-jeet"
    virtual_network_name = "vnet-todoapp"
    subnet_name          = "frontend-subnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
}
public_ip_frontend = {
  PIP1 = {
    public_ip_name      = "pip-todoapp-frontend"
    resource_group_name = "rg-jeet"
    location            = "centralindia"
    allocation_method   = "Static"
  }
}

key_vault = {
  vault1 = {
    key_vault_name      = "jeetkitihori"
    location            = "centralindia"
    resource_group_name = "rg-jeet"
  }
}
username = {
  UN1 = {
    key_vault_name      = "jeetkitihori"
    resource_group_name = "rg-jeet"
    secret_name         = "vm-username"
    secret_value        = "devopsadmin"
  }
}
vm_password = {
  PS1 = {
    key_vault_name      = "jeetkitihori"
    resource_group_name = "rg-jeet"
    secret_name         = "vm-password"
    secret_value        = "P@ssw01rd@123"
  }
}

frontend_vm = {
  FVM1 = {
    resource_group_name  = "rg-jeet"
    location             = "centralindia"
    vm_name              = "vm-frontend"
    vm_size              = "Standard_B1s"
    image_publisher      = "Canonical"
    image_offer          = "0001-com-ubuntu-server-focal"
    image_sku            = "20_04-lts"
    image_version        = "latest"
    nic_name             = "nic-vm-frontend"
    frontend_ip_name     = "pip-todoapp-frontend"
    vnet_name            = "vnet-todoapp"
    frontend_subnet_name = "frontend-subnet"
    key_vault_name       = "jeetkitihori"
    username_secret_name = "vm-username"
    password_secret_name = "vm-password"
  }
}

sql_server = {
  SQL1 = {
    sql_server_name              = "todosqlserver008"
    resource_group_name          = "rg-jeet"
    location                     = "centralindia"
    administrator_login          = "sqladmin"
    administrator_login_password = "P@ssw0rd1234!"
  }
}
sql_database = {
  DB1 = {
    sql_server_name     = "todosqlserver008"
    resource_group_name = "rg-jeet"
    sql_database_name   = "tododb"
  }
}
  