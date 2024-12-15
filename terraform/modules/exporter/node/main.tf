resource "kubernetes_daemonset" "node_exporter" {
  metadata {
    name      = "node-exporter"
    namespace = var.namespace
  }

  spec {
    selector {
      match_labels = {
        app = "node-exporter"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-exporter"
        }
      }

      spec {
        container {
          name  = "node-exporter"
          image = var.image
          args  = ["--path.rootfs=/host"]

          volume_mount {
            name       = "root"
            mount_path = "/host"
            read_only  = true
          }

          port {
            container_port = 9100
          }
        }

        volume {
          name = "root"
          host_path {
            path = "/"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "node_exporter" {
  metadata {
    name      = "node-exporter"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "node-exporter"
    }

    port {
      protocol    = "TCP"
      port        = 9100
      target_port = 9100
    }
  }
}