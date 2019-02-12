#!/bin/bash

set -euo pipefail

until curl -s "http://kibana:5601/login" | grep "Loading Kibana" > /dev/null; do
	  echo "Waiting for kibana..."
	  sleep 5
done

# apm-server.yml needs to be owned by root
chown root /usr/share/apm-server/apm-server.yml

echo "Creating keystore..."
echo "y" | /usr/share/apm-server/apm-server keystore create --force

echo "Adding ELASTIC_PASSWORD to keystore..."
echo "$ELASTIC_PASSWORD" | /usr/share/apm-server/apm-server keystore add 'ELASTIC_PASSWORD' --stdin
/usr/share/apm-server/apm-server keystore list

echo "Setting up dashboards..."
# Load the sample dashboards for APM.
# REF: https://www.elastic.co/guide/en/apm/server/current/load-kibana-dashboards.html
/usr/share/apm-server/apm-server setup --dashboards

echo "Copy keystore to ./config dir"
mv /usr/share/apm-server/apm-server.keystore /config/apm-server/apm-server.keystore
chown 1000:1000 /config/apm-server/apm-server.keystore
