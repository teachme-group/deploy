variable "kafka_host" {
  description = "Hostname for Kafka"
  type        = string
}

variable "namespace" {
    description = "Namespace for Kafka"
    type        = string
    default     = "default"
}

variable "name" {
    description = "Service/Deployment name for Kafka"
    type        = string
    default     = "kafka"
}