
TAG=$(shell git describe --abbrev=0 --tags)

NAME=conftest
IMAGE=instrumenta/$(NAME)

COMMAND=docker
BUILD=DOCKER_BUILDKIT=1 $(COMMAND) build
PUSH=$(COMMAND) push

all: push

examples:
	$(BUILD) --target examples -t instrumenta/conftest:examples .

acceptance:
	$(BUILD) --target acceptance .

conftest:
	$(BUILD) -t $(IMAGE):$(TAG) .
	$(COMMAND) tag $(IMAGE):$(TAG) $(IMAGE):latest

push: examples conftest
	$(PUSH) $(IMAGE):$(TAG)
	$(PUSH) $(IMAGE):latest
	$(PUSH) $(IMAGE):examples

.PHONY: examples acceptance conftest push all
