# Azure Terraform Virtual Network

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-0078D4?logo=microsoft-azure)](https://azure.microsoft.com/)
[![License](https://img.shields.io/github/license/atulkamble/Azure-Terraform-Vnet)](LICENSE)

A production-ready Terraform configuration for deploying Azure Virtual Network infrastructure with multiple subnets. This project demonstrates best practices for Azure networking using Infrastructure as Code (IaC).

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Resources Created](#resources-created)
- [Outputs](#outputs)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [References](#references)
- [License](#license)

## 🎯 Overview

This Terraform project creates a complete Azure Virtual Network (VNet) infrastructure including:
- A resource group to contain all networking resources
- A virtual network with customizable address space (default: 10.0.0.0/16)
- Two subnets for network segmentation:
  - **Subnet A**: For application workloads (10.0.1.0/24)
  - **Subnet B**: For database or backend services (10.0.2.0/24)

## 🏗️ Architecture

```
Azure Subscription
└── Resource Group (myRG)
    └── Virtual Network (myvnet - 10.0.0.0/16)
        ├── Subnet A (subnetA - 10.0.1.0/24)
        └── Subnet B (subnetB - 10.0.2.0/24)
```

## ✨ Features

- **Modular Design**: Separate files for variables, outputs, and main configuration
- **Parameterized**: All values configurable via variables
- **Well-Documented**: Comprehensive inline comments and documentation
- **Production-Ready**: Includes validation rules and best practices
- **Tagging Support**: Built-in resource tagging for organization and cost tracking
- **Idempotent**: Safe to run multiple times without side effects
- **State Management**: Supports remote state backends

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.0
- An active Azure subscription
- Appropriate Azure permissions to create resources

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/atulkamble/Azure-Terraform-Vnet.git
cd Azure-Terraform-Vnet
```

### 2. Authenticate with Azure

```bash
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Plan

```bash
terraform plan
```

### 5. Deploy the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 6. View Outputs

After successful deployment, view the outputs:

```bash
terraform output
```

## ⚙️ Configuration

### Customize Variables

Create a `terraform.tfvars` file to override default values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
resource_group_name = "my-custom-rg"
location            = "eastus"
vnet_name          = "my-vnet"
vnet_address_space = ["10.0.0.0/16"]

subnet_a_name   = "app-subnet"
subnet_a_prefix = ["10.0.1.0/24"]

subnet_b_name   = "db-subnet"
subnet_b_prefix = ["10.0.2.0/24"]

tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Project     = "MyProject"
  Owner       = "Your Name"
  CostCenter  = "Engineering"
}
```

### Available Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `resource_group_name` | Name of the Azure Resource Group | string | "myRG" |
| `location` | Azure region for deployment | string | "centralindia" |
| `vnet_name` | Name of the Virtual Network | string | "myvnet" |
| `vnet_address_space` | VNet address space in CIDR notation | list(string) | ["10.0.0.0/16"] |
| `subnet_a_name` | Name of Subnet A | string | "subnetA" |
| `subnet_a_prefix` | Address prefix for Subnet A | list(string) | ["10.0.1.0/24"] |
| `subnet_b_name` | Name of Subnet B | string | "subnetB" |
| `subnet_b_prefix` | Address prefix for Subnet B | list(string) | ["10.0.2.0/24"] |
| `tags` | Tags to apply to resources | map(string) | See variables.tf |

## 📖 Usage

### Basic Deployment

```bash
# Initialize the working directory
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply -auto-approve

# Show current state
terraform show

# List all resources
terraform state list
```

### Custom Configuration

Deploy with custom variables:

```bash
terraform apply \
  -var="resource_group_name=custom-rg" \
  -var="location=westus" \
  -var="vnet_name=custom-vnet"
```

### Destroy Infrastructure

Remove all created resources:

```bash
terraform destroy
```

## 🔧 Resources Created

This configuration creates the following Azure resources:

1. **Resource Group** (`azurerm_resource_group`)
   - Container for all networking resources
   - Tagged for organization and cost tracking

2. **Virtual Network** (`azurerm_virtual_network`)
   - Isolated network environment
   - Default address space: 10.0.0.0/16
   - Supports up to 65,536 IP addresses

3. **Subnet A** (`azurerm_subnet`)
   - Application tier subnet
   - Default: 10.0.1.0/24 (256 addresses)

4. **Subnet B** (`azurerm_subnet`)
   - Database/backend tier subnet
   - Default: 10.0.2.0/24 (256 addresses)

## 📤 Outputs

After deployment, the following information is available:

| Output | Description |
|--------|-------------|
| `resource_group_id` | Resource Group ID |
| `resource_group_name` | Resource Group name |
| `resource_group_location` | Resource Group location |
| `vnet_id` | Virtual Network ID |
| `vnet_name` | Virtual Network name |
| `vnet_address_space` | VNet address space |
| `vnet_guid` | VNet GUID |
| `subnet_a_id` | Subnet A ID |
| `subnet_a_address_prefix` | Subnet A address prefix |
| `subnet_b_id` | Subnet B ID |
| `subnet_b_address_prefix` | Subnet B address prefix |
| `deployment_summary` | Complete deployment summary |

### View Specific Output

```bash
# View all outputs
terraform output

# View specific output
terraform output vnet_id

# Output in JSON format
terraform output -json
```

## 🎓 Best Practices

This configuration follows Terraform and Azure best practices:

### 1. **Separation of Concerns**
- Variables in `variables.tf`
- Outputs in `outputs.tf`
- Main configuration in `main.tf`

### 2. **Variable Validation**
- Input validation for resource names
- Azure region validation
- CIDR notation checks

### 3. **Resource Dependencies**
- Explicit `depends_on` declarations
- Proper resource references
- Prevents race conditions

### 4. **Tagging Strategy**
- Environment identification
- Cost center tracking
- Management tool identification
- Project association

### 5. **Version Pinning**
- Terraform version constraint
- Provider version constraint (~> 4.54)
- Ensures consistent deployments

### 6. **Security**
- `.gitignore` for sensitive files
- Example tfvars file (not actual values)
- State file exclusion

### 7. **Documentation**
- Inline code comments
- Variable descriptions
- Output descriptions
- README documentation

## 🔍 Troubleshooting

### Common Issues

**Issue**: `Error: Subscription not found`
```bash
# Solution: Set the correct subscription
az account list
az account set --subscription "SUBSCRIPTION_ID"
```

**Issue**: `Error: Resource group already exists`
```bash
# Solution: Either use a different name or import existing
terraform import azurerm_resource_group.myrg /subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME
```

**Issue**: `Error: Address space overlaps`
```bash
# Solution: Choose a different CIDR block that doesn't conflict
# Check existing VNets: az network vnet list
```

### Debug Mode

Enable detailed logging:

```bash
export TF_LOG=DEBUG
terraform apply
```

### Validate Configuration

```bash
# Check syntax
terraform validate

# Format code
terraform fmt -recursive

# Check for style issues
tflint
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📚 References

### Official Documentation
- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Network Documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)

### Related Repositories
- [Azure Terraform Reference Guide](https://github.com/atulkamble/Azure-Terraform-Reference-Guide)
- [Terraform Provider Examples](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)

### Learning Resources
- [Terraform Registry](https://registry.terraform.io/)
- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Atul Kamble**

- GitHub: [@atulkamble](https://github.com/atulkamble)
- Repository: [Azure-Terraform-Vnet](https://github.com/atulkamble/Azure-Terraform-Vnet)

## 🌟 Support

If you find this project helpful, please give it a ⭐️ on GitHub!

---

**Note**: Remember to review and update the subscription ID in the provider configuration before deploying to your Azure environment.
