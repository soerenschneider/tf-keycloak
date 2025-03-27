realm = {
  name        = "test"
  server_name = "localhost"
}

groups = [
  {
    group_name = "admins"
    roles = {
      grafana = [
        "admin"
      ]
    }
    members = [
      "soeren"
    ]
  }
]

clients = {
  grafana = {
    client_id = "grafana",
    #checkov:skip=CKV_SECRET_6:local dev environment
    secret_id = "XQldTKiMwYyWPEarMJrI4DGrFFguct6Y" #gitleaks:allow
    redirect_urls = [
      "http://localhost:3000/*",
      "http://grafana:3000/*",
    ],
    roles = [
      "admin",
      "editor",
      "viewer"
    ]
  },
  whoami = {
    client_id = "whoami",
    #checkov:skip=CKV_SECRET_6:local dev environment
    secret_id = "rU82vBEqhHlRWyOiqdxhJaxlonQgd0qS" #gitleaks:allow
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
    email        = "mail@soeren.de",
    username     = "soeren"
    first_name   = "soeren"
    last_name    = "soerensen",
    client_roles = {}
  },
  {
    email      = "nereos@soeren.de",
    username   = "nereos"
    first_name = "nereos"
    last_name  = "soerensen",
    client_roles = {
      grafana : [
        "editor"
      ]
    }
  }
]
