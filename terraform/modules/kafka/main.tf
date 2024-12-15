resource "kubernetes_persistent_volume" "kafka_pv" {
  metadata {
    name = "kafka-pv"
  }

  spec {
    capacity = {
      "storage" = "10Gi"
    }

    volume_mode = "Filesystem"
    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      host_path {
        path = "/mnt/data/kafka"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "kafka_pvc" {
  metadata {
    name      = "kafka-pvc"
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }

    volume_name = kubernetes_persistent_volume.kafka_pv.metadata[0].name
  }
}

resource "kubernetes_service" "kafka_headless_service" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    cluster_ip = "None" # Headless service (no cluster IP)
    port {
      port        = 9092
      target_port = 9092
    }

    selector = {
      app = "kafka"
    }
  }
}
resource "kubernetes_stateful_set" "kafka" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    service_name = "kafka"
    replicas     = 1
    selector {
      match_labels = {
        app = "kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka"
        }
      }

      spec {
        init_container {
          name  = "init-permissions"
          image = "busybox"
          command = ["sh", "-c", "chmod -R 777 /var/lib/kafka/data"]
          volume_mount {
            name       = "kafka-storage"
            mount_path = "/var/lib/kafka/data"
          }
        }

        container {
          name  = "kafka"
          image = "confluentinc/cp-kafka:latest" # Используйте образ Kafka, поддерживающий KRaft режим
          port {
            container_port = 9092
          }

          env {
            name  = "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP"
            value = "PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT"
          }

          env {
            name  = "KAFKA_LISTENERS"
            value = "PLAINTEXT://0.0.0.0:9092,CONTROLLER://0.0.0.0:9093" # Добавьте слушатели
          }

          env {
            name  = "KAFKA_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://kafka.monitoring.svc.cluster.local:9092" # Обновите объявленные слушатели
          }

          env {
            name  = "KAFKA_CONTROLLER_LISTENER_NAMES"
            value = "CONTROLLER" # Убедитесь, что это соответствует вашим слушателям
          }

          env {
            name  = "KAFKA_INTER_BROKER_LISTENER_NAME"
            value = "PLAINTEXT"
          }

          env {
            name  = "KAFKA_KRAFT_MODE"
            value = "true"
          }

          env {
            name  = "KAFKA_PROCESS_ROLES"
            value = "broker,controller"
          }

          env {
            name  = "KAFKA_NODE_ID"
            value = "1"
          }

          env {
            name  = "KAFKA_CONTROLLER_QUORUM_VOTERS"
            value = "1@localhost:9093"
          }

          env {
            name  = "CLUSTER_ID"
            value = "B1d9FyhPRJ-aXLZ7buvU5A"
          }

          volume_mount {
            mount_path = "/var/lib/kafka/data"
            name       = "kafka-storage"
          }
        }

        volume {
          name = "kafka-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.kafka_pvc.metadata[0].name
          }
        }
      }
    }
  }
}
