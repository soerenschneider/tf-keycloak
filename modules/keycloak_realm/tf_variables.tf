variable "name" {
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "display_name" {
  type    = string
  default = ""
}

variable "display_name_html" {
  type    = string
  default = "<b>Welcome to Middle Earth</b>"
}

variable "server_name" {
  type = string
}
