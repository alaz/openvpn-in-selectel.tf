data "openstack_networking_network_v2" "external_net" {
  name     = var.router_external_net_name
  region   = var.region
  external = true
}

resource "openstack_networking_router_v2" "router" {
  name                    = var.router_name
  external_network_id     = data.openstack_networking_network_v2.external_net.id
  region                  = var.region
  availability_zone_hints = [var.zone]
}

resource "openstack_networking_network_v2" "network" {
  name                    = var.network_name
  availability_zone_hints = [var.zone]
}

resource "openstack_networking_subnet_v2" "subnet" {
  network_id      = openstack_networking_network_v2.network.id
  region          = var.region
  dns_nameservers = var.dns_nameservers
  name            = var.subnet_cidr
  cidr            = var.subnet_cidr
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
  region    = var.region
}
