resource "openstack_compute_flavor_v2" "flavor" {
  name      = var.name
  ram       = var.ram_mb
  vcpus     = var.vcpus
  disk      = var.local_disk_gb
  is_public = var.is_public

  lifecycle {
    create_before_destroy = true
  }
}
