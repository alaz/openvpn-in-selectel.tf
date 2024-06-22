output "floatingip_id" {
  value = module.floatingip.address
}

output "project_name" {
  value = random_string.project_name.result
}

output "private_key" {
  value     = module.serviceuser.private_key
  sensitive = true
}
