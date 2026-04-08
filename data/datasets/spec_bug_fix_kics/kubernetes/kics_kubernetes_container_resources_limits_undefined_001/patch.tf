resource "kubernetes_pod" "example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    container {
      image = "nginx:1.19.2"
      name  = "example"

      resources {
        requests {
          cpu    = "50m"
          memory = "64Mi"
        }

        limits {
          cpu    = "100m"
          memory = "128Mi"
        }
      }

      env {
        name  = "MY_ENV_VAR"
        value = "production"
      }

      port {
        container_port = 8080
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 8080
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }

    dns_config {
      nameservers = ["1.1.1.1", "8.8.8.8", "9.9.9.9"]
      searches    = ["example.com"]

      option {
        name  = "ndots"
        value = 1
      }

      option {
        name = "use-vc"
      }
    }

    dns_policy = "None"
  }
}
