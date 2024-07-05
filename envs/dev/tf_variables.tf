variable "realm" {
  type = object({
    name              = string
    enabled           = optional(bool)
    server_name       = string
    display_name      = optional(string)
    display_name_html = optional(string)
  })
}

variable "clients" {
  type = map(object({
    client_id     = string
    secret_id     = optional(string)
    redirect_urls = list(string)
    roles         = optional(set(string))
  }))
}

variable "users" {
  type = list(object({
    username     = string
    email        = string
    first_name   = string
    last_name    = string
    enabled      = optional(bool, true)
    client_roles = map(set(string))
  }))
}
