variable "grafana_host" {
  description = "Hostname for Grafana"
  type        = string
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
}

variable "name" {
  description = "Service/Deployment name for Grafana"
  type        = string
  default = "grafana"
}

variable "namespace" {
  description = "Namespace for Grafana"
  type        = string
  default = "default"
}