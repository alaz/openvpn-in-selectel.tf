resource "random_string" "server_name" {
  length  = 5
  upper   = false
  special = false
}

module "flavor" {
  source = "./flavor"
  name   = "flavor-${random_string.server_name.result}"
  vcpus  = var.vcpus
  ram_mb = var.ram_mb
}

module "image" {
  source = "./images"
  name   = var.image_name
}

module "key_pair" {
  source = "./key_pair"
  region = var.region
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name              = "volume-for-${random_string.server_name.result}"
  size              = var.root_disk_gb
  image_id          = module.image.id
  volume_type       = var.volume_type
  region            = var.region
  availability_zone = var.zone

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_networking_port_v2" "port" {
  name       = "${random_string.server_name.result}-eth0"
  network_id = var.network_id

  fixed_ip {
    subnet_id = var.subnet_id
  }
}

resource "openstack_compute_instance_v2" "instance" {
  name              = random_string.server_name.result
  flavor_id         = module.flavor.id
  key_pair          = module.key_pair.id
  availability_zone = var.zone

  network {
    port = openstack_networking_port_v2.port.id
  }

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.volume.id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  tags = var.preemptible_tag

  vendor_options {
    ignore_resize_confirmation = true
  }

  # TODO: provision OpenVPN
}

resource "openstack_networking_floatingip_associate_v2" "association" {
  port_id     = openstack_networking_port_v2.port.id
  floating_ip = var.floatingip_address
}
