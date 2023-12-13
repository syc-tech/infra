include ../../.env
export $(shell sed 's/=.*//' ../../.env)

init:
	terraform init -backend-config=../backend.tfbackend

init-reconfigure:
	terraform init -backend-config=../backend.tfbackend -reconfigure


plan:
	terraform plan

plan-cd:
	terraform plan -no-color -out=tfplan

refresh:
	terraform refresh

apply:
	terraform apply
	
# apply-cd:
# 	terraform apply -auto-approve -input=false -no-color tfplan

apply-cd:
	terraform apply -auto-approve -input=false -no-color

destroy: 
	terraform destroy

taint-all:
	module=$1\
	for resource in `terraform show -module-depth=1 | grep module.${module} | tr -d ':' | sed -e 's/module.${module}.//'`; do\
		terraform taint -module ${module} ${resource}\
	done

list: 
	terraform state list

temporal-manifest:
	# cd helm_charts/temporal && helm repo add
	# cd helm_charts/temporal && helm dependency build
	cd helm_charts/temporal && helm template . --namespace temporal \
		--set server.replicaCount=1 --set cassandra.config.cluster_size=2 \
		--set prometheus.enabled=false --set grafana.enabled=false\
		--set elasticsearch.enabled=false --values ./values.yaml\
		--name-template temporal01\
		> ../../argo_apps/temporal/manifest.yml

temporal-deploy-helm:
	# cd helm_charts/temporal && helm repo add
	# cd helm_charts/temporal && helm dependency build
	cd helm_charts/temporal && helm install . --namespace temporal \
		--set server.replicaCount=1 --set cassandra.config.cluster_size=2 \
		--set prometheus.enabled=false --set grafana.enabled=false\
		--set elasticsearch.enabled=false --values ./values.yaml\
		--name-template temporal01 --debug\
		> ../../argo_apps/temporal/manifest.yml