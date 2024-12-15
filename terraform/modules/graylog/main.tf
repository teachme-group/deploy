resource "kubernetes_deployment" "graylog" {
  metadata {
    name      = "graylog"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "graylog"
      }
    }

    template {
      metadata {
        labels = {
          app = "graylog"
        }
      }

      spec {
        container {
          name  = "graylog"
          image = "graylog/graylog:6.1"

          env {
            name  = "GRAYLOG_MONGO_URI"
            value = "mongodb://root:rootpassword@mongo:27017/graylog?authSource=admin"
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "400Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 9000
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 9000
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          startup_probe {
            http_get {
              path = "/"
              port = 9000
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "graylog" {
  metadata {
    name      = "graylog"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "graylog"
    }

    port {
      port        = 9000
      target_port = 9000
    }

    type = "ClusterIP"
  }
}


resource "kubernetes_horizontal_pod_autoscaler" "graylog" {
  metadata {
    name      = "graylog"
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.graylog.metadata[0].name
    }

    min_replicas                    = 1
    max_replicas                    = 10
    target_cpu_utilization_percentage = 60
  }
}