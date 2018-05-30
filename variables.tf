/// Required
variable "gcp_project" {
  description = "The project that prometheus will be deployed to."
  type        = "string"
}

variable "gcp_zone" {
  description = "The host zone where prometheus will be deployed to."
  type        = "string"
}

variable "gcp_network" {
  description = "Network that the firewall rules will be associated with."
  type        = "string"
}

variable "gcp_subnetwork" {
  description = "Subnetwork to attach the instance to."
  type        = "string"
}

variable "disk_image" {
  description = "Disk image to use when deploying prometheus. This module assumes that you have already deployed an image that has prometheus installed and configured."
  type        = "string"
}

/// Optional
variable "deployment_name" {
  description = "Name to identify the prometheus deployement."
  type        = "string"
  default     = "prometheus"
}

variable "machine_type" {
  description = "Instance size to deploy prometheus on to."
  type        = "string"
  default     = "g1-small"
}

variable "server_tags" {
  description = "Network tags to identify the server."
  type        = "list"
  default     = ["prometheus", "prometheus-server", "consul-client"]
}

variable "server_scopes" {
  description = "The instance's permissions to different GCP services."
  type        = "list"
  default     = ["compute-ro", "logging-write", "storage-rw", "monitoring"]
}

variable "server_source_ranges" {
  description = "The source ranges allowed access to communicate with the prometheus server."
  type        = "list"
  default     = []
}

variable "server_source_tags" {
  description = "The source ranges allowed access to communicate with the prometheus server."
  type        = "list"
  default     = []
}

variable "node_exporter_ranges" {
  description = "The source ranges allowed to access to communicate with the node exporter."
  type        = "list"
  default     = []
}

variable "node_exporter_tags" {
  description = "The source tags allowed to access to communicate with the node exporter."
  type        = "list"
  default     = []
}
