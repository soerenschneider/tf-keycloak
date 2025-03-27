terraform {
  required_version = ">= 1.7.0"
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.1.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }

  encryption {
    method "aes_gcm" "default" {
      keys = key_provider.pbkdf2.mykey
    }

    state {
      enforced = true
      method   = method.aes_gcm.default
    }
    plan {
      method   = method.aes_gcm.default
      enforced = true
    }
  }
}

provider "vault" {
  address = "https://localhost:8200"
  #checkov:skip=CKV_SECRET_6:local dev environment
  token = "test"
}

provider "keycloak" {
  client_id = "admin-cli"
  url       = "https://auth.dd.soeren.cloud"
}
