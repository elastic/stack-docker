SHELL=/bin/bash

ifndef ELASTIC_VERSION
ELASTIC_VERSION := $(shell awk 'BEGIN { FS = "[= ]" } /^ELASTIC_VERSION=/ { print $$2 }' .env)
endif
export ELASTIC_VERSION

ifndef STAGING_BUILD_NUM
STAGING_BUILD_NUM := $(shell awk 'BEGIN { FS = "[- ]" } /^TAG=/ { printf $$2 }' .env)
endif
export STAGING_BUILD_NUM

ifndef BRANCH
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
endif

TARGETS := elasticsearch logstash kibana beats

images: $(TARGETS)
push: $(TARGETS:%=%-push)
clean: $(TARGETS:%=%-clean)

$(TARGETS): $(TARGETS:%=%-checkout)
	(cd stack/$@ && make)

$(TARGETS:%=%-push): $(TARGETS:%=%-checkout)
	(cd stack/$(@:%-push=%) && make push)

$(TARGETS:%=%-checkout):
	test -d stack/$(@:%-checkout=%) || \
          git clone https://github.com/elastic/$(@:%-checkout=%)-docker.git stack/$(@:%-checkout=%)
	(cd stack/$(@:%-checkout=%) && git fetch && git reset --hard origin/$(BRANCH))

$(TARGETS:%=%-clean):
	rm -rf stack/$(@:%-clean=%)
