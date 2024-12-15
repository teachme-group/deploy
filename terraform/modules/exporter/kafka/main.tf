resource "kubernetes_deployment" "kafka_exporter" {
  metadata {
    name      = "kafka-exporter"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kafka-exporter"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka-exporter"
        }
      }

      spec {
        container {
          name  = "kafka-exporter"
          image = var.image
          args  = ["--kafka.server=${var.kafka_broker}"]

          port {
            container_port = 9308
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "kafka_exporter" {
  metadata {
    name      = "kafka-exporter"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "kafka-exporter"
    }

    port {
      protocol    = "TCP"
      port        = 9308
      target_port = 9308
    }
  }
}