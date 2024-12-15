variable "namespace" {
  description = "Namespace for Node Exporter"
  type        = string
  default     = "default"
}

variable "image" {
  description = "Image for Node Exporter"
  type        = string
  default     = "quay.io/prometheus/node-exporter:latest"
}