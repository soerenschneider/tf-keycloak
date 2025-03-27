variable "username" {
  type = string
}

variable "first_name" {
  type = string
}

variable "last_name" {
  type = string
}

variable "email" {
  type = string
}

variable "email_verified" {
  type    = bool
  default = true
}

variable "enabled" {
  type    = bool
  default = true
}

variable "realm_id" {
  type = string

  validation {
    condition     = length(var.realm_id) > 0
    error_message = "realm_id must not be empty."
  }
}

variable "client_roles" {
  type    = set(string)
  default = []
}
