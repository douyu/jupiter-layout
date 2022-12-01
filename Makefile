
.PHONY: init
# install tools
init:
	go install github.com/douyu/jupiter/cmd/jupiter@v0.9.9
	go install github.com/google/wire/cmd/wire@v0.5.0
	go install github.com/vektra/mockery/v2@v2.14.0
	go install gorm.io/gen/tools/gentool@v0.3.13
	go install github.com/bufbuild/buf/cmd/buf@v1.9.0

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

.PHONY: test
# test
test:
	go test -v -mod=vendor -cover -race ./...

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