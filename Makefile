build:
	docker build  --platform linux/amd64 . -t qadiludmer/temporal-test:latest

run:
	docker run qadiludmer/temporal-test:latest poetry run worker

shell:
	docker run -it qadiludmer/temporal-test:latest bash

push:
	docker push qadiludmer/temporal-test:latest

deploy:
	kubectl apply -f deployment.yml

undeploy:
	kubectl delete -f deployment.yml

local-temporal-cluster:
	docker-compose up
