terraform {
  required_version = ">= 1.7.0"
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.1.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
