SHELL=/bin/bash
ifndef ELASTIC_VERSION
ELASTIC_VERSION=5.2.2
endif
export ELASTIC_VERSION

BRANCH=`echo $$ELASTIC_VERSION | egrep --only-matching '^[0-9]+.[0-9]+'`

IMAGE_TARGETS := elasticsearch logstash kibana beats

# Every image gets a matching push target like "make beats-push".
PUSH_TARGETS := $(foreach t,$(IMAGE_TARGETS),$(t)-push)

images: $(IMAGE_TARGETS)
push: $(PUSH_TARGETS)

$(IMAGE_TARGETS): submodules
	(cd $@ && make)

$(PUSH_TARGETS): submodules
	(cd $(subst -push,,$@) && make push)

submodules:
	git submodule update --init --recursive
	git submodule foreach git fetch --all
	git submodule foreach git reset --hard origin/$(BRANCH)
