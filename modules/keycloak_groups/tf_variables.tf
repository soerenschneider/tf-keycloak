variable "group_name" {
  type = string

  validation {
    condition     = length(var.group_name) > 0
    error_message = "name must not be empty."
  }
}

variable "realm_id" {
  type = string

  validation {
    condition     = length(var.realm_id) > 0
    error_message = "realm_id must not be empty."
  }
}

variable "role_ids" {
  type    = set(string)
  default = []
}

variable "members" {
  type    = set(string)
  default = []
}
