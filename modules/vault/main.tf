resource "vault_kv_secret_v2" "tokens" {
  for_each            = { for path in var.password_store_paths : path => path }
  mount               = var.vault_kv2_mount
  name                = format(each.value, var.access_keys.name)
  delete_all_versions = true
  data_json = jsonencode(
    {
      client_id = var.access_keys.client_id
      secret_id = var.access_keys.secret_id
    }
  )
  custom_metadata {
    max_versions = 1
    data         = var.metadata
  }
}
