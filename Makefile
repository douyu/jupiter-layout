
.PHONY: init
# install tools
init:
	go install github.com/bufbuild/buf/cmd/buf
	go install github.com/douyu/jupiter/cmd/jupiter
	go install github.com/douyu/jupiter/cmd/protoc-gen-go-echo
	go install github.com/douyu/jupiter/cmd/protoc-gen-go-gin
	go install github.com/douyu/jupiter/cmd/protoc-gen-go-xerror
	go install github.com/envoyproxy/protoc-gen-validate
	go install github.com/go-swagger/go-swagger/cmd/swagger
	go install github.com/google/wire/cmd/wire
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	go install github.com/onsi/ginkgo/v2/ginkgo
	go install github.com/srikrsna/protoc-gen-gotag
	go install github.com/vektra/mockery/v2
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go install google.golang.org/protobuf/cmd/protoc-gen-go
	go install gorm.io/gen/tools/gentool

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

gen-deployment:
	kompose convert -f deployment/docker-compose-for-k8s.yml -o deployment/install.yml

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