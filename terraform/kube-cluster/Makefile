include ../../.env
export $(shell sed 's/=.*//' ../../.env)

init:
	terraform init -backend-config=./../backend.tfbackend

init-reconfigure:
	terraform init -backend-config=./../backend.tfbackend -reconfigure

init-upgrade:
	terraform init -backend-config=../backend.tfbackend -upgrade

test:
	echo $(TF_VAR_DO_TOKEN)

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