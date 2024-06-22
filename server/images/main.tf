data "openstack_images_image_v2" "image" {
  name        = var.name
  visibility  = "public"
  most_recent = true
}
