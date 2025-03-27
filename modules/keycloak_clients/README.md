<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 5.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 5.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_openid_audience_protocol_mapper.audience_mapper](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/openid_audience_protocol_mapper) | resource |
| [keycloak_openid_client.client](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/openid_client) | resource |
| [keycloak_openid_user_client_role_protocol_mapper.user_client_role_mapper](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/openid_user_client_role_protocol_mapper) | resource |
| [keycloak_role.roles](https://registry.terraform.io/providers/keycloak/keycloak/5.1.1/docs/resources/role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_claim_name"></a> [claim\_name](#input\_claim\_name) | n/a | `string` | `"roles"` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_flow_id"></a> [flow\_id](#input\_flow\_id) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this client | `string` | n/a | yes |
| <a name="input_realm_id"></a> [realm\_id](#input\_realm\_id) | n/a | `string` | n/a | yes |
| <a name="input_redirect_urls"></a> [redirect\_urls](#input\_redirect\_urls) | n/a | `list(string)` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | n/a | `set(string)` | `[]` | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_keys"></a> [access\_keys](#output\_access\_keys) | n/a |
| <a name="output_role_ids"></a> [role\_ids](#output\_role\_ids) | n/a |
<!-- END_TF_DOCS -->