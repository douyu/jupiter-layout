# Douyu Golang Application Standard Makefile

SHELL:=/bin/bash
BASE_PATH:=$(shell dirname $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
BUILD_PATH:=$(BASE_PATH)/build
TITLE:=$(shell basename $(BASE_PATH))
BUILD_TIME:=$(shell date +%Y-%m-%d--%T)
COMMIT_VERSION:= $(shell git log -1 --pretty=format:%h)
JUPITER:= github.com/douyu/jupiter/pkg
LDFLAGS:= "-X $(JUPITER).appName=$(APP_NAME) -X $(JUPITER).appID=$(APP_ID) -X $(JUPITER).buildTime=$(BUILD_TIME) -X $(JUPITER).buildAppVersion=$(COMMIT_VERSION)" 
all:print build tar

print:
	@echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>making print<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	@echo SHELL:$(SHELL)
	@echo BASE_PATH:$(BASE_PATH)
	@echo BUILD_PATH:$(BUILD_PATH)
	@echo TITLE:$(TITLE)
	@echo BUILD_TIME:$(BUILD_TIME)
	@echo COMMIT_VERSION:$(COMMIT_VERSION)
	@echo BINS:$(BINS)
	@echo APP_NAME:$(APP_NAME)
	@echo LDFLAGS:$(LDFLAGS)
	@echo -e "\n"

build:
	@echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>making build<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	@chmod +x $(BUILD_PATH)/script/shell/*.sh
	$(BUILD_PATH)/script/shell/build.sh $(LDFLAGS) $(BINS)
	@echo -e "\n"

tar:
	@echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>making tar<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	$(eval TAR=$(BASE_PATH)/$(TITLE).tar.gz)
	@cd $(BASE_PATH) && tar zcf $(TAR) * >/dev/null
	@echo $(TAR)
	@echo -e "\n"


