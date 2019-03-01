locals {
  container_type      = "${upper(var.container_type)}"
  container_config    = "${base64encode(var.container_config)}"
  app_service_plan_id = "${var.app_service_plan_id != "" ? var.app_service_plan_id : element(coalescelist(azurerm_app_service_plan.main.*.id, list("")), 0)}"
}

data "azurerm_resource_group" "main" {
  name = "${var.resource_group_name}"
}

resource "azurerm_app_service_plan" "main" {
  count               = "${var.app_service_plan_id == "" ? 1 : 0}"
  name                = "${var.name}-plan"
  location            = "${data.azurerm_resource_group.main.location}"
  resource_group_name = "${data.azurerm_resource_group.main.name}"
  kind                = "linux"
  reserved            = true

  sku {
    tier = "${var.sku_tier}"
    size = "${var.sku_size}"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.name}"
  location            = "${data.azurerm_resource_group.main.location}"
  resource_group_name = "${data.azurerm_resource_group.main.name}"
  app_service_plan_id = "${local.app_service_plan_id}"

  https_only = "${var.https_only}"

  site_config {
    app_command_line = "${var.command}"
    ftps_state       = "${var.ftps_state}"
    linux_fx_version = "${local.container_type}|${local.container_type == "DOCKER" ? var.container_image : local.container_config}"
  }

  app_settings {
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "${var.start_time_limit}"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "${var.enable_storage}"
    "WEBSITES_PORT"                       = "${var.port}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = "${var.docker_registry_username}"
    "DOCKER_REGISTRY_SERVER_URL"          = "${var.docker_registry_url}"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = "${var.docker_registry_password}"
  }
}

resource "azurerm_app_service_custom_hostname_binding" "main" {
  count               = "${length(var.custom_hostnames)}"
  hostname            = "${var.custom_hostnames[count.index]}"
  app_service_name    = "${azurerm_app_service.main.name}"
  resource_group_name = "${data.azurerm_resource_group.main.name}"
}