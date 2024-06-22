variable "user_id" {
  type        = string
  description = "Service user ID"
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "Selectel account ID"
}

variable "project_id" {
  type        = string
  description = "The project ID"
}

variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "region" {
  type        = string
  description = "The name of the Selectel's region."

  default = "ru-7"

  validation {
    condition     = can(regex("ru-7", var.region))
    error_message = "Preemtible servers are available in ru-7a pool only."
  }
}

variable "zone" {
  type        = string
  description = "The name of the Selectel's pool."

  default = "ru-7a"

  validation {
    condition     = can(regex("ru-7a", var.zone))
    error_message = "Preemtible servers are available in ru-7a pool only."
  }
}
