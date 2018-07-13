#!/bin/bash

set -euo pipefail

beat=$1

until curl -s -k http://kibana:5601; do
    echo "Waiting for kibana..."
    sleep 5
done
sleep 5

chmod go-w /usr/share/$beat/$beat.yml


echo "Creating keystore..."
# create beat keystore
${beat} --strict.perms=false keystore create --force
chown 1000 /usr/share/$beat/$beat.keystore
chmod go-w /usr/share/$beat/$beat.yml

echo "adding ES_PASSWORD to keystore..."
echo "$ELASTIC_PASSWORD" | ${beat} --strict.perms=false keystore add ELASTIC_PASSWORD --stdin
${beat} --strict.perms=false keystore list

echo "Setting up dashboards..."
# Load the sample dashboards for the Beat.
# REF: https://www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-sample-dashboards.html
${beat} --strict.perms=false setup -v

echo "Copy keystore to ./config dir"
cp /usr/share/$beat/$beat.keystore /config/$beat/$beat.keystore
chown 1000:1000 /config/$beat/$beat.keystore
