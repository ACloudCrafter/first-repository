vms = {
    vm1 = {
        subnet_name = "frontend-subnet"
        virtual_network_name = "first-vnet"
        nic_name = "first-nic"
        location = "centralindia"
        resource_group_name = "first-rg"
        vm_name = "first-vm"
        size = "Standard_F2"
    }
     vm2 = {
        subnet_name = "backend-subnet"
        virtual_network_name = "first-vnet"
        nic_name = "second-nic"
        location = "centralindia"
        resource_group_name = "first-rg"
        vm_name = "second-vm"
        size = "Standard_F2"
    }
}