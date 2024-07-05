variable "access_keys" {
  type = object({
    name      = string,
    client_id = string,
    secret_id = string
  })
}

variable "path" {
  type        = string
  description = "Paths to write the secret to."

  validation {
    condition     = length(var.path) >= 5
    error_message = "Each path in password_store_paths must be at least 5 characters long."
  }

  validation {
    condition     = !startswith(var.path, "/") && !endswith(var.path, "/")
    error_message = "Each path in password_store_paths must not start or end with a slash ('/')."
  }

  validation {
    condition     = can(regex("%s", var.path))
    error_message = "Each path in password_store_paths must contain the substring '%s'."
  }
}

variable "vault_kv2_mount" {
  type    = string
  default = "secret"

  validation {
    condition     = !endswith(var.vault_kv2_mount, "/") && length(var.vault_kv2_mount) > 3
    error_message = "vault_kv2_mount should not end with a slash."
  }
}

variable "metadata" {
  type        = map(any)
  default     = null
  description = "Optional metadata to attach to the secret."
}
