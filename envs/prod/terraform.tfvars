realm = {
  name        = "test"
  server_name = "localhost"
}

clients = {
  whoami = {
    client_id = "whoami",
    redirect_urls = [
      "http://localhost:4180/*",
      "http://oauth2-proxy:4180/*",
    ]
  }
  httpbin = {
    client_id = "httpbin",
    redirect_urls = [
      "http://localhost:4180/*",
      "http://oauth2-proxy:4180/*",
    ]
  }
}

users = [
  {
    email      = "mail@soerensoerensen.de",
    username   = "soeren"
    first_name = "soeren"
    last_name  = "soerensen",
    client_roles = {
      grafana = [
        "admin"
      ]
    }
  }
]
