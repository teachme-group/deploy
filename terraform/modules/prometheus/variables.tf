variable "prometheus_host" {
  description = "Hostname for Prometheus"
  type        = string
}

variable "prometheus_config" {
  description = "Config path for Prometheus"
  type        = string
}

variable "name" {
    description = "Service/Deployment name for Prometheus"
    type        = string
    default = "prometheus"
}

variable "namespace" {
    description = "Namespace for Prometheus"
    type        = string
    default = "default"
}