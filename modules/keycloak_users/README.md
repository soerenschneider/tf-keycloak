<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 5.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 5.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_user.user_with_initial_password](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/user) | resource |
| [keycloak_user_roles.user_roles](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/user_roles) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/3.7.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_roles"></a> [client\_roles](#input\_client\_roles) | n/a | `set(string)` | `[]` | no |
| <a name="input_email"></a> [email](#input\_email) | n/a | `string` | n/a | yes |
| <a name="input_email_verified"></a> [email\_verified](#input\_email\_verified) | n/a | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_first_name"></a> [first\_name](#input\_first\_name) | n/a | `string` | n/a | yes |
| <a name="input_last_name"></a> [last\_name](#input\_last\_name) | n/a | `string` | n/a | yes |
| <a name="input_realm_id"></a> [realm\_id](#input\_realm\_id) | n/a | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_initial_password"></a> [initial\_password](#output\_initial\_password) | n/a |
<!-- END_TF_DOCS -->