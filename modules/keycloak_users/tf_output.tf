output "initial_password" {
  value     = keycloak_user.user_with_initial_password.initial_password[0].value
  sensitive = true
}

output "id" {
  value = keycloak_user.user_with_initial_password.id
}
