variable "graylog_host" {
  description = "Hostname for Graylog"
  type        = string
}

variable "graylog_password_secret" {
  description = "Password secret for Graylog"
  type        = string
}

variable "graylog_root_password_sha2" {
  description = "Root password SHA2 for Graylog"
  type        = string
}

variable "namespace" {
  description = "Namespace for Graylog"
  type        = string
  default = "default"
}

variable "name" {
  description = "Service/Deployment name for Graylog"
  type        = string
  default = "graylog"
}