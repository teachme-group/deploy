variable "postgres_host" {
  description = "Hostname for PostgreSQL"
  type        = string
  default = "postgres.example.com"
}

variable "postgres_password" {
  description = "Password for PostgreSQL"
  type        = string
  default = "blank"
}

variable "postgres_user" {
  description = "User for PostgreSQL"
  type        = string
  default = "root"
}

variable "postgres_db" {
  description = "Database name for PostgreSQL"
  type        = string
  default =   "postgres_db"
}

variable "namespace" {
  description = "Namespace for PostgreSQL"
  type        = string
  default = "default"
}

variable "name" {
  description = "Service/Deployment name for PostgreSQL"
  type        = string
  default = "postgres"
}