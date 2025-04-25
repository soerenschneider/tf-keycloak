<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 5.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 5.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_openid_client_scope.openid_client_scope](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/openid_client_scope) | resource |
| [keycloak_realm.realm](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/realm) | resource |
| [keycloak_required_action.custom-configured_totp](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/required_action) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | n/a | `string` | `""` | no |
| <a name="input_display_name_html"></a> [display\_name\_html](#input\_display\_name\_html) | n/a | `string` | `"<b>Welcome to Middle Earth</b>"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_realm_id"></a> [realm\_id](#output\_realm\_id) | n/a |
<!-- END_TF_DOCS -->