TAG?=1.0.0
REGISTRY?=hshishir
APPNAME?=

build:
	docker build --build-arg OS=darwin --build-arg ARCH=amd64 -t $(APPNAME):$(TAG) .

build-osx:
	docker build --build-arg OS=darwin --build-arg ARCH=amd64 -t $(APPNAME):$(TAG) .
	@docker create --name $(APPNAME) $(APPNAME):$(TAG) \
	&& docker cp $(APPNAME):/usr/bin/$(APPNAME) . \
	&& docker rm -f $(APPNAME)

push:
	docker tag $(APPNAME):$(TAG) $(REGISTRY)/$(APPNAME):$(TAG)
	docker push $(REGISTRY)/$(APPNAME):$(TAG)