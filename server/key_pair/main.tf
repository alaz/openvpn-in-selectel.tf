resource "random_string" "name" {
  length  = 8
  upper   = false
  special = false
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = random_string.name.result
  public_key = tls_private_key.key.public_key_openssh
  region     = var.region
}
