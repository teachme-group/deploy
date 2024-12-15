variable "jaeger_host" {
  description = "Hostname for Jaeger"
  type        = string
}

variable "jaeger_collector_zipkin_http_port" {
  description = "Zipkin HTTP port for Jaeger"
  type        = string
}

variable "jaeger_query_base_path" {
  description = "Base path for Jaeger Query"
  type        = string
}

variable "namespace" {
  description = "Namespace for Jaeger"
  type        = string
  default = "default"
}

variable "name" {
  description = "Service/Deployment name for Jaeger"
  type        = string
  default = "jaeger"
}