resource "kubernetes_deployment" "jaeger" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jaeger"
      }
    }

    template {
      metadata {
        labels = {
          app = "jaeger"
        }
      }

      spec {
        container {
          name  = "jaeger"
          image = "jaegertracing/all-in-one:latest"

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
              port = 16686
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 16686
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }

          startup_probe {
            http_get {
              path = "/"
              port = 16686
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "jaeger" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "jaeger"
    }

    port {
      port        = 16686
      target_port = 16686
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "jaeger" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.jaeger.metadata[0].name
    }

    min_replicas                    = 1
    max_replicas                    = 10
    target_cpu_utilization_percentage = 60
  }
}