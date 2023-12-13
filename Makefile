
run-local-backend:
	cd docker-compose && docker-compose -f local.yml up

run-local-db:
	cd docker-compose && docker-compose -f db.yml up

push-db:
	npx prisma db push --schema=./prisma/schema.prisma
	
setup:
	npm install