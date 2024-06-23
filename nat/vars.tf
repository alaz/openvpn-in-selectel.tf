variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "router_external_net_name" {
  default = "external-network"
}

variable "router_name" {
  default = "router"
}

variable "network_name" {
  default = "network"
}

variable "subnet_cidr" {
  default = "192.168.0.0/24"
}

variable "dns_nameservers" {
  default = [
    "188.93.16.19",
    "188.93.17.19",
  ]
}
