#!/bin/bash

# Wait for Kibana to start up before doing anything.
until curl -s http://kibana:5601/login -o /dev/null; do
    echo Waiting for Kibana...
    sleep 1
done

# Create a Kibana index pattern for Logstash.
# There's currently no API for creating index patterns, so this is a bit hackish.
curl -s -XPUT http://elastic:changeme@elasticsearch:9200/.kibana/index-pattern/logstash-* \
     -d '{"title" : "logstash-*",  "timeFieldName": "@timestamp"}'

# Set the default index pattern.
curl -s -XPUT http://elastic:changeme@elasticsearch:9200/.kibana/config/${ELASTIC_VERSION} \
     -d '{"defaultIndex" : "metricbeat-*"}'
