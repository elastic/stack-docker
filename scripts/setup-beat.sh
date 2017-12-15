#!/bin/bash

set -euo pipefail

beat=$1
es_url=http://elastic:${ELASTIC_PASSWORD}@elasticsearch:9200


until curl -s http://kibana:5601; do
    sleep 2
done
sleep 5

# Load the sample dashboards for the Beat.
# REF: https://www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-sample-dashboards.html
${beat} setup \
        -E setup.kibana.host=kibana \
        -E setup.kibana.username=elastic \
        -E setup.kibana.password=${ELASTIC_PASSWORD}
