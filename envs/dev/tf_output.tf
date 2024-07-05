output "clients" {
  value = {
    soeren = "bla"
  }
  sensitive = true
}

output "pass" {
  value = {
    for user in var.users : user.email => module.users[user.username].initial_password
  }
  sensitive = true
}

output "roles" {
  value = {
    for client in var.clients : client.client_id => module.clients[client.client_id].role_ids
  }
}
