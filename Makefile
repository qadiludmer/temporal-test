build:
	docker build  --platform linux/amd64 . -t qadiludmer/temporal-test:latest

push:
	docker push qadiludmer/temporal-test:latest

deploy:
	kubectl apply -f deployment.yml

undeploy:
	kubectl delete -f deployment.yml

local-temporal-cluster:
	docker-compose up
