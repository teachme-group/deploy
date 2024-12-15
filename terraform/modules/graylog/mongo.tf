resource "kubernetes_persistent_volume" "mongo_pv" {
  metadata {
    name = "mongo-pv"
  }

  spec {
    capacity = {
      storage = "5Gi"
    }

    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      gce_persistent_disk {
        pd_name = "mongo-pv-disk"
        fs_type = "ext4"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "mongo_pvc" {
  metadata {
    name      = "mongo-pvc"
    namespace = var.namespace
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "mongo" {
  metadata {
    name      = "mongo"
    namespace = var.namespace
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mongo"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }

      spec {
        container {
          name  = "mongo"
          image = "mongo:4.4"

          env {
            name  = "MONGO_MAX_CONNECTIONS"
            value = "1000"
          }

          args = [
            "--maxConnections", "1000"
          ]

          volume_mount {
            mount_path = "/data/db"
            name       = "mongo-storage"
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
        }

        volume {
          name = "mongo-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mongo_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_job" "mongo_user_creation" {
  metadata {
    name      = "mongo-user-creation"
    namespace = var.namespace
  }

  spec {
    template {
      metadata {
        name = "mongo-user-creation"
      }

      spec {
        container {
          name  = "mongo"
          image = "mongo:4.4"
          command = [
            "sh", "-c", "mongo --eval 'db.createUser({user:\"monitor\", pwd:\"password\", roles:[\"clusterMonitor\"]});'"
          ]

          env {
            name  = "MONGO_INITDB_ROOT_USERNAME"
            value = "root"
          }

          env {
            name  = "MONGO_INITDB_ROOT_PASSWORD"
            value = "rootpassword"
          }
        }

        restart_policy = "OnFailure"
      }
    }
  }
}

resource "kubernetes_service" "mongo" {
  metadata {
    name      = "mongo"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "mongo"
    }

    port {
      port        = 27017
      target_port = 27017
    }

    type = "ClusterIP"
  }
}