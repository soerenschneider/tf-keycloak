locals {
  default_password_policy = "upperCase(1) and length(16) and forceExpiredPasswordChange(365) and notUsername"
  locales                 = ["en"]
}

resource "keycloak_realm" "realm" {
  realm             = var.name
  enabled           = var.enabled
  display_name      = var.display_name
  display_name_html = var.display_name_html

  login_theme = "keycloak"

  access_code_lifespan = "5m"

  ssl_required    = "external"
  password_policy = local.default_password_policy
  attributes = {
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
      permanent_lockout                = false
      max_login_failures               = 30
      wait_increment_seconds           = 60
      quick_login_check_milli_seconds  = 1000
      minimum_quick_login_wait_seconds = 60
      max_failure_wait_seconds         = 900
      failure_reset_time_seconds       = 43200
    }
  }

  web_authn_policy {
    relying_party_entity_name = "Keycloak"
    relying_party_id          = var.server_name
    signature_algorithms = [
      "ES256",
      "RS256"
    ]
  }
}

resource "keycloak_required_action" "custom-configured_totp" {
  realm_id       = keycloak_realm.realm.realm
  alias          = "CONFIGURE_TOTP"
  default_action = true
  enabled        = true
  name           = "Custom configure totp"
}
