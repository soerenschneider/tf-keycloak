variable "name" {
  type        = string
  description = "The name of this client"
}

variable "realm_id" {
  type = string

  validation {
    condition     = length(var.realm_id) > 0
    error_message = "realm_id must not be empty."
  }
}

variable "redirect_urls" {
  type = list(string)
  validation {
    condition     = length(var.redirect_urls) > 0 && alltrue([for url in var.redirect_urls : can(regex("https?://.*", url))])
    error_message = "Each URL in the list must start with 'http://' or 'https://'."
  }
}

variable "claim_name" {
  type    = string
  default = "roles"
}

variable "client_id" {
  type = string

  validation {
    condition     = length(var.client_id) > 0
    error_message = "client_id must not be empty."
  }
}

variable "secret_id" {
  type    = string
  default = null
}

variable "roles" {
  type    = set(string)
  default = []
}

variable "flow_id" {
  type    = string
  default = ""
}
