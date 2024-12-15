variable "postgres_dsn" {
  description = "PostgreSQL DSN"
  type        = string
  default = "postgres.database.svc.local:5432"
}

variable "namespace" {
  description = "Namespace for PostgreSQL Exporter"
  type        = string
  default     = "database"
}

variable "image" {
  description = "Image for PostgreSQL Exporter"
  type        = string
  default     = "wrouesnel/postgres_exporter:latest"
}
