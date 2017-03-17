SHELL=/bin/bash
ifndef ELASTIC_VERSION
ELASTIC_VERSION=5.2.2
endif
export ELASTIC_VERSION

BRANCH=`echo $$ELASTIC_VERSION | egrep --only-matching '^[0-9]+.[0-9]+'`

all: elasticsearch logstash kibana beats

push: elasticsearch-push logstash-push kibana-push beats-push

submodules:
	git submodule update --init --recursive
	git submodule foreach git fetch --all
	git submodule foreach git reset --hard origin/$(BRANCH)

elasticsearch: submodules
	make --directory=elasticsearch

elasticsearch-push: elasticsearch
	make push --directory=elasticsearch

logstash: submodules
	make --directory=logstash

logstash-push: submodules
	make push --directory=logstash

kibana: submodules
	make --directory=kibana

kibana-push: submodules
	make push --directory=kibana

beats: submodules
	make --directory=beats

beats-push: submodules
	make push --directory=beats
