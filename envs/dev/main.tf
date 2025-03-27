locals {
  instance                     = basename(abspath(path.module))
  password_store_paths_default = ["env/${local.instance}/keycloak/${var.realm.name}/clients/%s"]
}

module "realm" {
  source            = "../../modules/keycloak_realm"
  name              = var.realm.name
  server_name       = var.realm.server_name
  enabled           = var.realm.enabled
  display_name      = var.realm.display_name
  display_name_html = var.realm.display_name_html
}

module "flow" {
  source   = "../../modules/keycloak_2fa_flow"
  realm_id = module.realm.realm_id
}

module "clients" {
  for_each      = var.clients
  source        = "../../modules/keycloak_clients"
  name          = each.key
  client_id     = coalesce(each.value.client_id, each.key)
  realm_id      = module.realm.realm_id
  redirect_urls = each.value.redirect_urls
  roles         = coalesce(each.value.roles, [])
  secret_id     = each.value.secret_id
  flow_id       = module.flow.flow_id
}

module "groups" {
  for_each   = { for o in var.groups : o.group_name => o }
  source     = "../../modules/keycloak_groups"
  group_name = each.key
  realm_id   = module.realm.realm_id
  members    = each.value.members
  role_ids = flatten([
    for client, roles in each.value.roles : [
      for role in roles : module.clients[client].role_ids[role]
    ]
  ])
}

module "users" {
  for_each       = { for o in var.users : o.username => o }
  source         = "../../modules/keycloak_users"
  realm_id       = module.realm.realm_id
  username       = each.key
  email          = each.value.email
  email_verified = true
  first_name     = each.value.first_name
  last_name      = each.value.last_name
  client_roles = flatten([
    for client, roles in each.value.client_roles : [
      for role in roles : module.clients[client].role_ids[role]
    ]
  ])
}

module "vault" {
  for_each             = var.clients
  source               = "../../modules/vault"
  access_keys          = nonsensitive(module.clients[each.key].access_keys)
  password_store_paths = coalescelist(each.value.password_store_paths, var.password_store_paths, local.password_store_paths_default)
  metadata = {
    env = local.instance
  }
}
