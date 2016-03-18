# Configure the Azure Resource Manager Provider
provider "azurerm" {
  subscription_id = "${var.azure-subscription-id}"
  client_id       = "${var.azure-client-id}"
  client_secret   = "${var.azure-client-secret}"
  tenant_id       = "${var.azure-tenant-id}"
}
