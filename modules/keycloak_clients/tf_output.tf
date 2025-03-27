output "access_keys" {
  value = {
    name      = var.name
    client_id = keycloak_openid_client.client.client_id
    secret_id = keycloak_openid_client.client.client_secret
  }
  sensitive = true
}

output "role_ids" {
  value = {
    for role in var.roles : role => keycloak_role.roles[role].id
  }
}
