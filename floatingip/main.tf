resource "selectel_vpc_floatingip_v2" "ip" {
  project_id = var.project_id
  region     = var.region
}
