resource "kubernetes_config_map" "krakend_config" {
  metadata {
    name      = "krakend-config"
    namespace = var.namespace
  }

  data = {
    "krakend.json" = "{\"version\":3,\"endpoints\":[{\"endpoint\":\"/api/v1/\",\"method\":\"GET\",\"backend\":{\"url_pattern\":\"http://api:8080\",\"encoding\":\"json\"}}]}"
  }
}

resource "kubernetes_deployment" "krakend" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "krakend"
      }
    }

    template {
      metadata {
        labels = {
          app = "krakend"
        }
      }

      spec {
        container {
          name  = var.name
          image = var.image
          port {
            container_port = 8080
          }

          volume_mount {
            name       = "krakend-config-volume"
            mount_path = "/etc/krakend/krakend.json"
            sub_path   = "krakend.json"
          }
        }

        volume {
          name = "krakend-config-volume"

          config_map {
            name = kubernetes_config_map.krakend_config.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "krakend" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "krakend"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8080
    }
  }
}