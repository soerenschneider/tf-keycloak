resource "keycloak_openid_client" "client" {
  realm_id  = var.realm_id
  client_id = var.client_id

  enabled = true

  access_type           = var.bot ? "BEARER-ONLY" : "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = var.redirect_urls
}
