variable "monitoring_namespace" {
    description = "Namespace for monitoring"
    type        = string
    default     = "monitoring"
}

variable "kafka_namespace" {
    description = "Namespace for Kafka"
    type        = string
    default     = "kafka"
}

variable "database_namespace" {
    description = "Namespace for database"
    type        = string
    default     = "database"
}