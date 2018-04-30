#/bin/ash
confdir="${PWD}/config"
chown 1000 -R "$confdir"
find "$confdir" -type f -name "*.keystore" -exec chmod go-wrx {} \;
find "$confdir" -type f -name "*.yml" -exec chmod go-wrx {} \;

docker-compose -f docker-compose.yml -f docker-compose.setup.yml up setup_elasticsearch

# restart Elasticsearch so CA's take effect.
docker restart elasticsearch

# setup kibana and logstash (and system passwords)
docker-compose -f docker-compose.yml -f docker-compose.setup.yml up setup_kibana setup_logstash
# setup beats and apm server
docker-compose -f docker-compose.yml -f docker-compose.setup.yml up setup_auditbeat setup_filebeat setup_heartbeat setup_metricbeat setup_packetbeat setup_apm_server

docker-compose -f docker-compose.yml -f docker-compose.setup.yml down --remove-orphans

echo "All setup please run: \n\tdocker-compose up -d"
