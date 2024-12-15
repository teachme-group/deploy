variable "namespace" {
  description = "Namespace for Kafka Exporter"
  type        = string
  default     = "kafka"
}

variable "image" {
  description = "Image for Kafka Exporter"
  type        = string
  default     = "danielqsj/kafka-exporter:latest"
}

variable "kafka_broker" {
  description = "Kafka broker address"
  type        = string
  default = "kafka.monitoring.svc.cluster.local:9092"
}