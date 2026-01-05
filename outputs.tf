#--------------------------------------------------------------
# Output Values
#--------------------------------------------------------------
# Export important resource information for use by other modules
# or for reference after deployment
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resource Group Outputs
#--------------------------------------------------------------
output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.myrg.id
}

output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.myrg.name
}

output "resource_group_location" {
  description = "The location of the Resource Group"
  value       = azurerm_resource_group.myrg.location
}

#--------------------------------------------------------------
# Virtual Network Outputs
#--------------------------------------------------------------
output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.myvnet.id
}

output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.myvnet.name
}

output "vnet_address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.myvnet.address_space
}

output "vnet_guid" {
  description = "The GUID of the Virtual Network"
  value       = azurerm_virtual_network.myvnet.guid
}

#--------------------------------------------------------------
# Subnet A Outputs
#--------------------------------------------------------------
output "subnet_a_id" {
  description = "The ID of Subnet A"
  value       = azurerm_subnet.subnetA.id
}

output "subnet_a_name" {
  description = "The name of Subnet A"
  value       = azurerm_subnet.subnetA.name
}

output "subnet_a_address_prefix" {
  description = "The address prefix of Subnet A"
  value       = azurerm_subnet.subnetA.address_prefixes
}

#--------------------------------------------------------------
# Subnet B Outputs
#--------------------------------------------------------------
output "subnet_b_id" {
  description = "The ID of Subnet B"
  value       = azurerm_subnet.subnetB.id
}

output "subnet_b_name" {
  description = "The name of Subnet B"
  value       = azurerm_subnet.subnetB.name
}

output "subnet_b_address_prefix" {
  description = "The address prefix of Subnet B"
  value       = azurerm_subnet.subnetB.address_prefixes
}

#--------------------------------------------------------------
# Summary Output
#--------------------------------------------------------------
output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    resource_group = azurerm_resource_group.myrg.name
    location       = azurerm_resource_group.myrg.location
    vnet_name      = azurerm_virtual_network.myvnet.name
    vnet_cidr      = azurerm_virtual_network.myvnet.address_space
    subnets = {
      subnet_a = {
        name = azurerm_subnet.subnetA.name
        cidr = azurerm_subnet.subnetA.address_prefixes
      }
      subnet_b = {
        name = azurerm_subnet.subnetB.name
        cidr = azurerm_subnet.subnetB.address_prefixes
      }
    }
  }
}
