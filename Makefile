all: elasticsearch logstash kibana beats

submodules:
	git submodule update --init --recursive
	git submodule foreach git reset --hard origin/master

elasticsearch: submodules
	make --directory=elasticsearch

logstash: submodules
	make --directory=logstash

kibana: submodules
	make --directory=kibana

beats: submodules
	make --directory=beats
