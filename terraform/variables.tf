variable "grafana_host" {
  description = "Hostname for Grafana"
  type        = string
  default     = "grafana.example.com"
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
  default     = "admin_password"
}

variable "graylog_host" {
  description = "Hostname for Graylog"
  type        = string
  default     = "graylog.example.com"
}

variable "graylog_password_secret" {
  description = "Password secret for Graylog"
  type        = string
  default     = "password_secret"
}

variable "graylog_root_password_sha2" {
  description = "Root password SHA2 for Graylog"
  type        = string
  default     = "root_password_sha2"
}

variable "jaeger_host" {
  description = "Hostname for Jaeger"
  type        = string
  default     = "jaeger.example.com"
}

variable "jaeger_collector_zipkin_http_port" {
  description = "Zipkin HTTP port for Jaeger"
  type        = string
  default     = "9411"
}

variable "jaeger_query_base_path" {
  description = "Base path for Jaeger Query"
  type        = string
  default     = "/jaeger"
}

variable "kafka_host" {
  description = "Hostname for Kafka"
  type        = string
  default     = "kafka.example.com"
}

variable "postgres_host" {
  description = "Hostname for PostgreSQL"
  type        = string
  default     = "postgres.example.com"
}

variable "postgres_password" {
  description = "Password for PostgreSQL"
  type        = string
  default     = "postgres_password"
}

variable "postgres_user" {
  description = "User for PostgreSQL"
  type        = string
  default     = "postgres_user"
}

variable "postgres_db" {
  description = "Database name for PostgreSQL"
  type        = string
  default     = "postgres_db"
}

variable "prometheus_host" {
  description = "Hostname for Prometheus"
  type        = string
  default     = "prometheus.example.com"
}

variable "prometheus_config" {
  description = "Config path for Prometheus"
  type        = string
  default     = "/etc/prometheus/prometheus.yml"
}

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