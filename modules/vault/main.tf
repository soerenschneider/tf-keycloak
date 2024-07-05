resource "vault_kv_secret_v2" "access_keys" {
  mount               = var.vault_kv2_mount
  name                = format(var.path, var.access_keys.name)
  delete_all_versions = true
  data_json = jsonencode(
    {
      client_id = var.access_keys.client_id
      secret_id = var.access_keys.secret_id
    }
  )
  custom_metadata {
    max_versions = 2
    data         = var.metadata
  }
}
