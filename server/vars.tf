variable "zone" {
  type = string
}

variable "region" {
  type = string
}

variable "floatingip_address" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "vcpus" {
  type    = number
  default = 1
}

variable "ram_mb" {
  type    = number
  default = 1024
}

variable "root_disk_gb" {
  type    = number
  default = 5 * 1024
}

variable "local_disk_gb" {
  type    = number
  default = 0
}

variable "image_name" {
  type    = string
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "volume_type" {
  type    = string
  default = "universal.ru-7a"
}

variable "preemptible_tag" {
  default = ["preemptible"]
}
