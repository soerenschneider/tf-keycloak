variable "realm_id" {
  type = string
}

variable "redirect_urls" {
  type = list(string)
}

variable "client_id" {
  type = string
}

variable "bot" {
  type = bool
  default = false
}
