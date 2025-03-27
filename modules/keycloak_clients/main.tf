resource "keycloak_openid_client" "client" {
  realm_id              = var.realm_id
  enabled               = true
  name                  = var.name
  client_id             = var.client_id
  client_secret         = var.secret_id
  access_type           = "CONFIDENTIAL"
  valid_redirect_uris   = var.redirect_urls
  standard_flow_enabled = true

  dynamic "authentication_flow_binding_overrides" {
    for_each = length(var.flow_id) > 0 ? [1] : []
    content {
      browser_id = var.flow_id
    }
  }
}

resource "keycloak_openid_audience_protocol_mapper" "audience_mapper" {
  realm_id  = var.realm_id
  client_id = keycloak_openid_client.client.id
  name      = "audience-mapper"

  included_custom_audience = var.client_id
}

resource "keycloak_role" "roles" {
  for_each    = { for x in var.roles : x => x }
  realm_id    = var.realm_id
  client_id   = keycloak_openid_client.client.id
  name        = each.value
  description = "role - ${each.value}"
}

resource "keycloak_openid_user_client_role_protocol_mapper" "user_client_role_mapper" {
  realm_id    = var.realm_id
  client_id   = keycloak_openid_client.client.id
  name        = var.client_id
  claim_name  = var.claim_name
  multivalued = true
}
