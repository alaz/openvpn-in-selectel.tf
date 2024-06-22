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

module "project" {
  source       = "./project"
  project_name = random_string.project_name.result
  region       = var.region
  zone         = var.zone
}

module "serviceuser" {
  source     = "./serviceuser"
  project_id = module.project.id
}

provider "openstack" {
  auth_url    = var.auth_url
  domain_name = var.domain_name
  tenant_id   = module.project.id
  user_name   = module.serviceuser.username
  password    = module.serviceuser.password
  region      = var.region
}

module "floatingip" {
  source     = "./floatingip"
  project_id = module.project.id
  region     = var.region
}

module "nat" {
  source = "./nat"

  depends_on = [
    module.project,
    module.serviceuser,
  ]
}

module "server" {
  source             = "./server"
  floatingip_address = module.floatingip.address
  keypair_name       = module.serviceuser.keypair_name
  network_id         = module.nat.network_id
  subnet_id          = module.nat.subnet_id
  zone               = var.zone
}

# TODO: download ovpn file https://stackoverflow.com/questions/62826649/terraform-download-local-file-from-remote-url-on-apply-and-delete-file-on-destro
