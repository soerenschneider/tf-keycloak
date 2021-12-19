output "clients" {
  value = tomap(
    {
      for key, value in module.clients : key => value
    }
  )
  sensitive = true
}
