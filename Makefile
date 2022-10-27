
.PHONY: init
# install tools
init:
	go install -v github.com/google/wire/cmd/wire@v0.5.0
	go install -v github.com/vektra/mockery/v2@v2.14.0
	go install -v gorm.io/gen/tools/gentool@v0.3.13

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