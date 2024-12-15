# k8s/terraform/modules/postgres_exporter/main.tf
resource "kubernetes_deployment" "postgres_exporter" {
  metadata {
    name      = "postgres-exporter"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres-exporter"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres-exporter"
        }
      }

      spec {
        container {
          name  = "postgres-exporter"
          image = var.image
          env {
            name  = "DATA_SOURCE_NAME"
            value = var.postgres_dsn
          }

          port {
            container_port = 9187
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres_exporter" {
  metadata {
    name      = "postgres-exporter"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "postgres-exporter"
    }

    port {
      protocol    = "TCP"
      port        = 9187
      target_port = 9187
    }
  }
}