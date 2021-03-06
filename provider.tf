

terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "3.6.0"
    }
  }
}

provider "keycloak" {
    client_id     = "admin-cli"
    username      = "admin"
    password      = "admin"
    url           = "http://localhost:8080"
}
