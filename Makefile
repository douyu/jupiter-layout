
.PHONY: init
# init tools
init:
	@echo "Installing tools from tools/tools.go"
	@cd tools && cat tools.go |grep _|awk -F '"' '{print $$2}' | xargs -tI % go install %

.PHONY: generate
# generate code
generate:
	go generate

.PHONY: build
# build
build:
	go build -mod=vendor -o ./tmp ./cmd/exampleserver

.PHONY: run
# run
run:
	jupiter run	-c cmd/exampleserver/.jupiter.toml

.PHONY: lint
# lint
lint:
	golangci-lint run -v

.PHONY: lintproto
# lintproto
lintproto:
	buf lint

.PHONY: test
# test
test:
	go test -coverprofile=coverage.txt -covermode=atomic ./...

.PHONY: e2e-test
# e2e-test
e2e-test:
	cd tests/e2e \
		&& ginkgo -r -race -cover -covermode=atomic -coverprofile=coverage.txt --randomize-suites --trace -coverpkg=github.com/douyu/jupiter-layout/... .\
		&& cd -

.PHONY: covsh-e2e
## Get the coverage of e2e test
covsh-e2e: 
	gocovsh --profile tests/e2e/coverage.txt

# validate openapi docs
validate:
	swagger validate api/helloworld/v1/helloworld.swagger.json

# serve openapi docs
serve:
	swagger serve api/helloworld/v1/helloworld.swagger.json

# gen-deployment install.yml
gen-deployment:
	cd deployment && kustomize build . -o install.yml

# gen-dev-deployment install.yml
gen-dev-deployment:
	cd deployment && kustomize build overlays/dev -o install.yml
	cd deployment && kustomize build overlays/dev-mirror -o install-mirror.yml

# deploy install.yml
deploy:
	cd deployment && kubectl apply -f install.yml

# undeploy install.yml
undeploy:
	cd deployment && kubectl delete -f install.yml

.PHONY: all
# run all
all:
	make generate;
	make test;
	make run;

# show help
help:
	@echo ''
	@echo 'Usage:'
	@echo ' make [target]'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\0-9]+:/ { \
	helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help