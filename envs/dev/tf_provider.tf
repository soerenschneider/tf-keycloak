terraform {
  required_version = ">= 1.7.0"
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.4.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
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
  address = "http://localhost:8200"
  #checkov:skip=CKV_SECRET_6:local dev environment
  token = "test"
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = "admin"
  password  = "admin"
  url       = "http://localhost:8080"
}
