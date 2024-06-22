resource "random_string" "user_name" {
  length  = 8
  upper   = false
  special = false
}

resource "random_string" "password" {
  length = 32
}

resource "selectel_iam_serviceuser_v1" "serviceuser" {
  name     = random_string.user_name.result
  password = random_string.password.result

  role {
    role_name  = "member"
    scope      = "project"
    project_id = var.project_id
  }
}

resource "random_string" "keypair_name" {
  length  = 8
  upper   = false
  special = false
}

resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "selectel_vpc_keypair_v2" "keypair" {
  name       = random_string.keypair_name.result
  public_key = tls_private_key.keypair.public_key_openssh
  user_id    = selectel_iam_serviceuser_v1.serviceuser.id

  lifecycle {
    ignore_changes = [regions]
  }
}
