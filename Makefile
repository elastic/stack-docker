all: elasticsearch logstash kibana

submodules:
	git submodule update --init --recursive

elasticsearch: submodules
	make --directory=elasticsearch

logstash: submodules
	make --directory=logstash

kibana: submodules
	make --directory=kibana
