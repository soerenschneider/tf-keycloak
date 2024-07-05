resource "random_password" "password" {
  length = 25
}

resource "keycloak_user" "user_with_initial_password" {
  realm_id       = var.realm_id
  username       = var.username
  enabled        = var.enabled
  email          = var.email
  email_verified = var.email_verified
  first_name     = var.first_name
  last_name      = var.last_name

  initial_password {
    value     = random_password.password.result
    temporary = true
  }
}

resource "keycloak_user_roles" "user_roles" {
  realm_id   = var.realm_id
  exhaustive = false
  user_id    = keycloak_user.user_with_initial_password.id

  role_ids = var.client_roles
}
