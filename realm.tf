locals {
  locales = ["en"]
  flow_alias = "2FA Browser"
}

resource "keycloak_authentication_flow" "browser_flow" {
  realm_id    = keycloak_realm.realm.id
  alias       = local.flow_alias
  description = "Customized Browser flow that forces 2FA"
}

resource "keycloak_authentication_execution" "cookie" {
  realm_id    = keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  authenticator     = "auth-cookie"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_flow.browser_flow]
}

resource "keycloak_authentication_execution" "identity_provider_redirector" {
  realm_id    = keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  authenticator     = "identity-provider-redirector"
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.cookie]
}

resource "keycloak_authentication_subflow" "password_and_2fa" {
  realm_id    = keycloak_realm.realm.id
  alias             = "Password and 2FA subflow"
  parent_flow_alias = keycloak_authentication_flow.browser_flow.alias
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.identity_provider_redirector]
}

resource "keycloak_authentication_execution" "username_password_form" {
  realm_id    = keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_subflow.password_and_2fa.alias
  authenticator     = "auth-username-password-form"
  requirement       = "REQUIRED"
}

resource "keycloak_authentication_subflow" "_2fa" {
  realm_id    = keycloak_realm.realm.id
  alias             = "2FA subflow"
  parent_flow_alias = keycloak_authentication_subflow.password_and_2fa.alias
  requirement       = "REQUIRED"
  depends_on        = [keycloak_authentication_execution.username_password_form]
}

resource "keycloak_authentication_execution" "otp_form" {
  realm_id    = keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_subflow._2fa.alias
  authenticator     = "auth-otp-form"
  requirement       = "ALTERNATIVE"
}

resource "keycloak_authentication_subflow" "otp_default" {
  realm_id    = keycloak_realm.realm.id
  alias             = "OTP Default Subflow"
  parent_flow_alias = keycloak_authentication_subflow._2fa.alias
  requirement       = "ALTERNATIVE"
  depends_on        = [keycloak_authentication_execution.otp_form]
}

resource "keycloak_authentication_execution" "otp_default_form" {
  realm_id    = keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_subflow.otp_default.alias
  authenticator     = "auth-otp-form"
  requirement       = "REQUIRED"
}


resource "keycloak_realm" "realm" {
  realm             = var.realm_name
  enabled           = var.realm_enabled
  display_name      = var.realm_display_name
  display_name_html = var.realm_display_name_html

  login_theme = "base"

  access_code_lifespan = "1h"

  ssl_required    = "external"
  password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"
  attributes      = {
    mycustomAttribute = "myCustomValue"
  }

  internationalization {
    supported_locales = local.locales
    default_locale    = local.locales[0]
  }

  security_defenses {
    headers {
      x_frame_options                     = "DENY"
      content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
      content_security_policy_report_only = ""
      x_content_type_options              = "nosniff"
      x_robots_tag                        = "none"
      x_xss_protection                    = "1; mode=block"
      strict_transport_security           = "max-age=31536000; includeSubDomains"
    }
    brute_force_detection {
      permanent_lockout                 = false
      max_login_failures                = 30
      wait_increment_seconds            = 60
      quick_login_check_milli_seconds   = 1000
      minimum_quick_login_wait_seconds  = 60
      max_failure_wait_seconds          = 900
      failure_reset_time_seconds        = 43200
    }
  }

  web_authn_policy {
    relying_party_entity_name = "Example"
    relying_party_id          = "keycloak.example.com"
    signature_algorithms      = ["ES256", "RS256"]
  }
}

module "clients" {
  source = "./clients"
  client_id = ""
  realm_id = keycloak_realm.realm.id
  redirect_urls = ["http://bla.de"]
}
