provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
}

provider "openstack" {
  auth_url            = var.auth_url
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  tenant_id           = var.project_id
  user_name           = var.username
  password            = var.password
  region              = var.region
  max_retries         = 5
}

module "floatingip" {
  source     = "./floatingip"
  project_id = var.project_id
  region     = var.region
}

module "nat" {
  source = "./nat"
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
