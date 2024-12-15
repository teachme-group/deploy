
variable "name" {
    description = "Service/Deployment name for Krakend"
    type        = string
    default     = "krakend-gateway"
}

variable "namespace" {
    description = "Namespace for Krakend"
    type        = string
    default     = "default"
}

variable "replicas" {
    description = "Number of replicas for Krakend"
    type        = number
    default     = 1
}

variable "image" {
    description = "Image for Krakend"
    type        = string
    default     = "devopsfaith/krakend:latest"
}