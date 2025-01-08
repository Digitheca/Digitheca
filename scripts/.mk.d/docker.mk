.PHONY: docker.image            \
		docker.image.create     \
		docker.image.delete     \
		docker.network          \
		docker.container        \
		docker.container.delete \
		docker.delete           \
		docker.container.create \
		docker.terminal         \
		docker.restart

docker.image: docker.image.create

docker.image.create:
	docker build --tag $(IMAGE_NAME):$(IMAGE_TAG) .

docker.image.delete: docker.container.delete
	docker image rm $(IMAGE_NAME):$(IMAGE_TAG)

docker.network:
	docker network create $(NETWORK_NAME) || true

docker.container: docker.container.create

docker.container.create:
	docker run                                     \
		--interactive                              \
		--tty                                      \
		--name $(CONTAINER_NAME)                   \
		--publish $(HOST_PORT):$(CONTAINER_PORT)   \
		--volume $(WINDOWS_PATH):$(CONTAINER_PATH) \
		--network $(NETWORK_NAME)                  \
		$(IMAGE_NAME):$(IMAGE_TAG)

docker.terminal:
	docker attach --detach-keys="ctrl-c" $(CONTAINER_NAME)

docker.restart:
	if docker ps -q -f name=$(CONTAINER_NAME) | grep -q .; then docker stop $(CONTAINER_NAME); fi
	docker start $(CONTAINER_NAME)

docker.container.delete:
	if docker ps -q -f name=$(CONTAINER_NAME) | grep -q .; then docker stop $(CONTAINER_NAME); fi
	docker rm $(APP_NAME)

docker.delete: docker.container.delete
	if docker ps -q -f name=$(CONTAINER_NAME) | grep -q .; then docker stop $(CONTAINER_NAME); fi
	docker rm $(APP_NAME)
