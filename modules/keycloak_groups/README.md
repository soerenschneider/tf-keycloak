<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 5.1.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 5.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_group.group](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/group) | resource |
| [keycloak_group_memberships.group_members](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/group_memberships) | resource |
| [keycloak_group_roles.group_roles](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/group_roles) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_members"></a> [members](#input\_members) | n/a | `set(string)` | `[]` | no |
| <a name="input_realm_id"></a> [realm\_id](#input\_realm\_id) | n/a | `string` | n/a | yes |
| <a name="input_role_ids"></a> [role\_ids](#input\_role\_ids) | n/a | `set(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->