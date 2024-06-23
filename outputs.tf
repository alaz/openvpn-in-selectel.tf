output "project_name" {
  value = random_string.project_name.result
}

output "floatingip_id" {
  value = module.floatingip.address
}
