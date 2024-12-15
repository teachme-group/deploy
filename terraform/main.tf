module "prepare" {
  source            = "./modules/prepare"
  monitoring_namespace = var.monitoring_namespace
  kafka_namespace      = var.kafka_namespace
  database_namespace   = var.database_namespace
}

module "prometheus" {
  source            = "./modules/prometheus"
  prometheus_host   = var.prometheus_host
  prometheus_config = var.prometheus_config
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "grafana" {
  source                = "./modules/grafana"
  grafana_host          = var.grafana_host
  grafana_admin_password = var.grafana_admin_password
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "jaeger" {
  source                        = "./modules/jaeger"
  jaeger_host                   = var.jaeger_host
  jaeger_collector_zipkin_http_port = var.jaeger_collector_zipkin_http_port
  jaeger_query_base_path        = var.jaeger_query_base_path
  namespace = var.monitoring_namespace
  depends_on = [module.prepare]
}

module "kafka" {
  source                = "./modules/kafka"
  kafka_host            = var.kafka_host
  namespace = var.kafka_namespace
  depends_on = [module.prepare]
}

module "postgresql" {
  source            = "./modules/postgresql"
  postgres_host     = var.postgres_host
  postgres_password = var.postgres_password
  postgres_user     = var.postgres_user
  postgres_db       = var.postgres_db
  namespace = var.database_namespace
  depends_on = [module.prepare]
}

module "krakend" {
  source            = "./modules/krakend"
  depends_on = [module.prepare]
}


module "kafka-exporter" {
  source            = "./modules/exporter/kafka"
  depends_on = [module.postgresql]
}

module "postgres-exporter" {
  source            = "./modules/exporter/postgres"
  depends_on = [module.postgresql]
}

module "node_exporter" {
  source    = "./modules/exporter/node"
  depends_on = [module.prepare]
}