locals {
  flow_alias = "2FA Browser"
}

resource "keycloak_authentication_flow" "browser_flow" {
  realm_id    = var.realm_id
  alias       = local.flow_alias
  description = "Customized Browser flow that forces 2FA"
}

resource "keycloak_authentication_execution" "cookie" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  authenticator     = "auth-cookie"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_flow.browser_flow]
}

resource "keycloak_authentication_execution" "identity_provider_redirector" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  authenticator     = "identity-provider-redirector"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.cookie]
}

resource "keycloak_authentication_subflow" "password_and_2fa" {
  realm_id          = var.realm_id
  alias             = "Password and 2FA subflow"
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.identity_provider_redirector]
}

resource "keycloak_authentication_execution" "username_password_form" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_subflow.password_and_2fa.alias
  authenticator     = "auth-username-password-form"
  requirement       = "REQUIRED"
}

resource "keycloak_authentication_subflow" "_2fa" {
  realm_id          = var.realm_id
  alias             = "2FA subflow"
  parent_flow_alias = keycloak_authentication_subflow.password_and_2fa.alias
  requirement       = "REQUIRED"
  depends_on        = [keycloak_authentication_execution.username_password_form]
}

resource "keycloak_authentication_execution" "webauthn_form" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_subflow._2fa.alias
  authenticator     = "webauthn-authenticator"
  requirement       = "ALTERNATIVE"
}

resource "keycloak_authentication_execution" "otp_form" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_subflow._2fa.alias
  authenticator     = "auth-otp-form"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.webauthn_form]
}

resource "keycloak_authentication_subflow" "otp_default" {
  realm_id          = var.realm_id
  alias             = "OTP Default Subflow"
  parent_flow_alias = keycloak_authentication_subflow._2fa.alias
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.otp_form]
}

resource "keycloak_authentication_execution" "otp_default_form" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_subflow.otp_default.alias
  authenticator     = "auth-otp-form"
  requirement       = "REQUIRED"
}
