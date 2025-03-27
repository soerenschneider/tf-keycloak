resource "keycloak_group" "group" {
  realm_id = var.realm_id
  name     = var.group_name
}

resource "keycloak_group_memberships" "group_members" {
  realm_id = var.realm_id
  group_id = keycloak_group.group.id

  members = var.members
}

resource "keycloak_group_roles" "group_roles" {
  realm_id = var.realm_id
  group_id = keycloak_group.group.id

  role_ids = var.role_ids
}
