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
	kubectl apply -f ./kaniko.yaml

deploy:
	kubectl apply -f deployment.yml
	#kubectl apply -f deployment-2.yml

undeploy:
	kubectl delete -f deployment.yml
	kubectl delete -f deployment-2.yml

local-temporal-cluster:
	docker-compose up

tunnel-temporal-web:
	kubectl port-forward --namespace temporal svc/temporal-web 8080:8080

tunnel-temporal-fe:
	kubectl port-forward --namespace temporal svc/temporal-frontend 7233:7233