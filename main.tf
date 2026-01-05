#--------------------------------------------------------------
# Azure Virtual Network Infrastructure
#--------------------------------------------------------------
# This Terraform configuration creates a complete Azure Virtual
# Network infrastructure including:
# - Resource Group
# - Virtual Network with custom address space
# - Two subnets (SubnetA and SubnetB)
#
# Author: Atul Kamble
# Repository: atulkamble/Azure-Terraform-Vnet
#--------------------------------------------------------------

#--------------------------------------------------------------
# Terraform Configuration
#--------------------------------------------------------------
terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.54"
    }
  }
}

#--------------------------------------------------------------
# Azure Provider Configuration
#--------------------------------------------------------------
# Configure the Microsoft Azure Provider with required features
provider "azurerm" {
  features {}
  subscription_id = "50818730-e898-4bc4-bc35-d998af53d719"
}

#--------------------------------------------------------------
# Resource Group
#--------------------------------------------------------------
# Create a Resource Group to contain all VNet resources
resource "azurerm_resource_group" "myrg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#--------------------------------------------------------------
# Virtual Network
#--------------------------------------------------------------
# Create a Virtual Network with the specified address space
# This VNet will contain multiple subnets for network segmentation
resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  address_space       = var.vnet_address_space
  tags                = var.tags

  depends_on = [azurerm_resource_group.myrg]
}

#--------------------------------------------------------------
# Subnet A
#--------------------------------------------------------------
# Create Subnet A for application workloads
# Address range: 10.0.1.0/24 (supports 256 addresses)
resource "azurerm_subnet" "subnetA" {
  name                 = var.subnet_a_name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = azurerm_resource_group.myrg.name
  address_prefixes     = var.subnet_a_prefix

  depends_on = [azurerm_virtual_network.myvnet]
}

#--------------------------------------------------------------
# Subnet B
#--------------------------------------------------------------
# Create Subnet B for database or backend workloads
# Address range: 10.0.2.0/24 (supports 256 addresses)
resource "azurerm_subnet" "subnetB" {
  name                 = var.subnet_b_name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = azurerm_resource_group.myrg.name
  address_prefixes     = var.subnet_b_prefix

  depends_on = [azurerm_virtual_network.myvnet]
}
