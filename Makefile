SHELL=/bin/bash
ifndef ELASTIC_VERSION
ELASTIC_VERSION=5.2.0
endif
export ELASTIC_VERSION

BRANCH=`echo $$ELASTIC_VERSION | egrep --only-matching '^[0-9]+.[0-9]+'`

all: elasticsearch logstash kibana beats

submodules:
	git submodule update --init --recursive
	git submodule foreach git fetch --all
	git submodule foreach git reset --hard origin/$(BRANCH)

elasticsearch: submodules
	make --directory=elasticsearch

logstash: submodules
	make --directory=logstash

kibana: submodules
	make --directory=kibana

beats: submodules
	make --directory=beats
