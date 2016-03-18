resource "azurerm_resource_group" "poc" {
    name     = "AppFactoryPOC"
    location = "West Europe"
}
sagfagasgas

resource "azurerm_availability_set" "poc" {
    name = "PocAvailabilitySet"
    location = "West Europe"
    resource_group_name = "${azurerm_resource_group.poc.name}"
}
