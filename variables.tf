variable "name" {
  type = "string"

  description = "The name of the web app."
}

variable "resource_group_name" {
  type = "string"

  description = "The name of an existing resource group to use for the web app."
}

variable "container_type" {
  type = "string"

  default = "docker"

  description = "Type of container. The options are: `docker`, `compose` or `kube`."
}

variable "container_config" {
  type = "string"

  default = ""

  description = "Configuration for the container. This should be YAML."
}

variable "container_image" {
  type = "string"

  default = ""

  description = "Container image name. Example: `innovationnorway/python-hello-world:latest`."
}

variable "port" {
  type = "string"

  default = ""

  description = "The value of the expected container port number."
}

variable "enable_storage" {
  type = "string"

  default = "false"

  description = "Mount an SMB share to the `/home/` directory."
}

variable "start_time_limit" {
  type = "string"

  default = "230"

  description = "Configure the amount of time (in seconds) the app service will wait before it restarts the container."
}

variable "command" {
  type = "string"

  default = ""

  description = "A command to be run on the container."
}

variable "app_service_plan_id" {
  type = "string"

  default = ""

  description = "The ID of an existing app service plan to use for the web app."
}

variable "sku_tier" {
  type = "string"

  default = "Standard"

  description = "The pricing tier of an app service plan to use for the web app."
}

variable "sku_size" {
  type = "string"

  default = "S1"

  description = "The instance size of an app service plan to use for the web app."
}

variable "https_only" {
  type = "string"

  default = true

  description = "Redirect all traffic made to the web app using HTTP to HTTPS."
}

variable "ftps_state" {
  type = "string"

  default = "Disabled"

  description = "Set the FTPS state value the web app. The options are: `AllAllowed`, `Disabled` and `FtpsOnly`."
}

variable "custom_hostnames" {
  type = "list"

  default = []

  description = "List of custom hostnames to use for the web app."
}

variable "docker_registry_username" {
  type = "string"

  default = ""

  description = "The container registry username."
}

variable "docker_registry_url" {
  type = "string"

  default = "https://index.docker.io"

  description = "The container registry url."
}

variable "docker_registry_password" {
  type = "string"

  default = ""

  description = "The container registry password."
}