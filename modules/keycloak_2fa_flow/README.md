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
| [keycloak_authentication_execution.cookie](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_execution.identity_provider_redirector](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_execution.otp_default_form](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_execution.otp_form](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_execution.username_password_form](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_execution.webauthn_form](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_execution) | resource |
| [keycloak_authentication_flow.browser_flow](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_flow) | resource |
| [keycloak_authentication_subflow._2fa](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_subflow) | resource |
| [keycloak_authentication_subflow.otp_default](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_subflow) | resource |
| [keycloak_authentication_subflow.password_and_2fa](https://registry.terraform.io/providers/keycloak/keycloak/5.2.0/docs/resources/authentication_subflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_realm_id"></a> [realm\_id](#input\_realm\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flow_id"></a> [flow\_id](#output\_flow\_id) | n/a |
<!-- END_TF_DOCS -->