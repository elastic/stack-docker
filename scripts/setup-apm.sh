#!/bin/bash

set -euo pipefail

apm-server=$1


until curl -s http://kibana:5601; do
    sleep 2
done
sleep 5

${apm-server} setup \
        -E setup.kibana.host=kibana \
        -E output.elasticsearch.hosts='["elasticsearch:9200"]' \
        -E apm-server.host=apm:8200 \
        -E output.elasticsearch.username=elastic \
        -E output.elasticsearch.password=${ELASTIC_PASSWORD}
