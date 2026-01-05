#--------------------------------------------------------------
# Input Variables
#--------------------------------------------------------------
# Define all input variables for the Azure VNet infrastructure
# These variables can be customized via terraform.tfvars or
# command-line flags (-var)
#--------------------------------------------------------------

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "myRG"

  validation {
    condition     = length(var.resource_group_name) > 0 && length(var.resource_group_name) <= 90
    error_message = "Resource group name must be between 1 and 90 characters."
  }
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "centralindia"

  validation {
    condition = contains([
      "centralindia", "southindia", "westindia",
      "eastus", "westus", "centralus",
      "westeurope", "northeurope",
      "southeastasia", "eastasia"
    ], var.location)
    error_message = "Invalid Azure region specified."
  }
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "myvnet"

  validation {
    condition     = length(var.vnet_name) >= 2 && length(var.vnet_name) <= 64
    error_message = "VNet name must be between 2 and 64 characters."
  }
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network in CIDR notation"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition     = length(var.vnet_address_space) > 0
    error_message = "At least one address space must be specified."
  }
}

variable "subnet_a_name" {
  description = "Name of Subnet A (typically for application tier)"
  type        = string
  default     = "subnetA"
}

variable "subnet_a_prefix" {
  description = "Address prefix for Subnet A in CIDR notation"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_b_name" {
  description = "Name of Subnet B (typically for database tier)"
  type        = string
  default     = "subnetB"
}

variable "subnet_b_prefix" {
  description = "Address prefix for Subnet B in CIDR notation"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "Azure-VNet-Demo"
  }
}
