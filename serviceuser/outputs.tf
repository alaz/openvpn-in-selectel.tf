output "user_id" {
  value = selectel_iam_serviceuser_v1.serviceuser.id
}

output "username" {
  value = random_string.user_name.result
}

output "password" {
  value = random_string.password.result
}

output "keypair_name" {
  value = random_string.keypair_name.result
}

output "private_key" {
  value = tls_private_key.keypair.private_key_openssh
}
