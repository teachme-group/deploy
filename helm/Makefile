create-namespaces:
	kubectl create namespace monitoring
	kubectl create namespace kafka
	kubectl create namespace grafana
	kubectl create namespace jaeger
	kubectl create namespace prometheus
	kubectl create namespace postgres

postgres:
	helm install postgres bitnami/postgresql -f postgresql/values.yaml --namespace=postgres

redeploy-postgres:
	helm upgrade postgres bitnami/postgresql -f postgresql/values.yaml --namespace=postgres

jaeger:
	helm install jaeger-all-in-one -f jaeger/values.yaml jaeger-all-in-one/jaeger-all-in-one --namespace=jaeger

redeploy-jaeger:
	helm upgrade jaeger-all-in-one -f jaeger/values.yaml jaeger-all-in-one/jaeger-all-in-one --namespace=jaeger

grafana:
	kubectl apply -f grafana/values.yaml --namespace=grafana

redeploy-grafana:
	kubectl apply -f grafana/values.yaml --namespace=grafana

prometheus:
	kubectl apply -f prometheus/values.yaml --namespace=prometheus

redeploy-prometheus:
	kubectl apply -f prometheus/values.yaml --namespace=prometheus


kafka:
	helm install kafka bitnami/kafka -f kafka/values.yaml --namespace=kafka
    kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.9.0-debian-12-r1 --namespace kafka --command -- sleep infinity

redeploy-kafka:
	helm upgrade kafka bitnami/kafka -f kafka/values.yaml --namespace=kafka
	kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.9.0-debian-12-r1 --namespace kafka --command -- sleep infinity


graylog:
	helm install --namespace "monitoring" graylog kongz/graylog \
		--set tags.install-mongodb=true \
		--set tags.install-opensearch=true \
		--set graylog.opensearch.version=7

redeploy-graylog:
	helm upgrade --namespace "monitoring" graylog kongz/graylog \
		--set tags.install-mongodb=true\
		--set tags.install-opensearch=true\
		--set graylog.opensearch.version=7




redeploy: redeploy-postgres redeploy-jaeger redeploy-grafana redeploy-prometheus redeploy-kafka redeploy-graylog

deploy: create-namespaces postgres jaeger grafana prometheus kafka graylog


.PHONY: deploy postgres jaeger grafana prometheus kafka graylog kibana create-namespaces redeploy

