#### VM-1 ####
resource "azurerm_subnet" "private1" { 
  name = "private1" 
  resource_group_name = "${var.resource_group_name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}" 
  address_prefix = "10.0.1.0/24" 
} 
resource "azurerm_subnet" "private2" { 
  name = "private2" 
  resource_group_name = "${var.resource_group_name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}" 
  address_prefix = "10.0.2.0/24" 
} 
 
resource "azurerm_subnet" "private3" { 
  name = "private3" 
  resource_group_name = "${var.resource_group_name}" 
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}" 
  address_prefix = "10.0.3.0/24" 
} 
# tags { 
#     environment = "staging" 
#   } 


### VM-2 ####

resource "azurerm_virtual_machine" "vm2" { 
  name = "vm2" 
  location = "${var.location}" 

  resource_group_name = "${var.resource_group_name}" 
  network_interface_ids = ["${azurerm_network_interface.nic2.id}"] 
  vm_size = "Standard_DS1_v2" 
  storage_image_reference { 
    publisher = "OpenLogic" 
    offer = "CentOS" 
    sku = "7.5" 
    version = "latest" 
  } 
  storage_os_disk { 
    name = "myosdisk2" 
    caching = "ReadWrite" 
    create_option = "FromImage" 
    managed_disk_type = "Standard_LRS" 
  } 
  os_profile { 
    computer_name = "vm2" 
    admin_username = "centos" 
  } 

  os_profile_linux_config { 
    disable_password_authentication = true 
    ssh_keys { 
    path = "/home/centos/.ssh/authorized_keys"
    key_data = "${file("/home/ec2-user/.ssh/id_rsa.pub")}"
     } 
  }
   tags { 
    environment = "staging" 
  } 
}