provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

resource "random_string" "project_name" {
  length  = 5
  upper   = false
  special = false
}

resource "selectel_vpc_project_v2" "project" {
  name = random_string.project_name.result
}

provider "openstack" {
  auth_url            = var.auth_url
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  tenant_id           = selectel_vpc_project_v2.project.id
  user_name           = var.username
  password            = var.password
  region              = var.region
  max_retries         = 5
}

module "floatingip" {
  source     = "./floatingip"
  project_id = selectel_vpc_project_v2.project.id
  region     = var.region
}

module "nat" {
  source = "./nat"
  region = var.region
  zone   = var.zone
}

module "server" {
  source             = "./server"
  floatingip_address = module.floatingip.address
  network_id         = module.nat.network_id
  subnet_id          = module.nat.subnet_id
  region             = var.region
  zone               = var.zone
}

# TODO: download ovpn file https://stackoverflow.com/questions/62826649/terraform-download-local-file-from-remote-url-on-apply-and-delete-file-on-destro
