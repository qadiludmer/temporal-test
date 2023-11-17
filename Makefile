build:
	docker build  --platform linux/amd64 . -t qadiludmer/temporal-test:0.1

run:
	docker run qadiludmer/temporal-test:latest poetry run worker

docker-secret:
	sh ./docker-secret.sh

shell:
	docker run -it qadiludmer/temporal-test:latest bash

push:
	docker push qadiludmer/temporal-test:latest

save:
	docker save qadiludmer/temporal-test:0.1 -o temporal-test.tar

build-on-k8s:
	kubectl delete -f ./kaniko.yaml
	kubectl apply -f ./kaniko.yaml

deploy:
	kubectl apply -f deployment.yml

undeploy:
	kubectl delete -f deployment.yml

local-temporal-cluster:
	docker-compose up
