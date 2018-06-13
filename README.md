# stack-docker
This example Docker Compose configuration demonstrates many components of the
Elastic Stack, all running on a single machine under Docker.

## Prerequisites
- Docker and Compose. Windows and Mac users get Compose installed automatically
with Docker. Linux users can:
```
pip install docker-compose
```

- At least 4GiB of RAM for the containers. Windows and Mac users _must_
configure their Docker virtual machine to have more than the default 2 GiB of
RAM:

![Docker VM memory settings](screenshots/docker-vm-memory-settings.png)

## Starting the stack
Try `docker-compose up` to create a demonstration Elastic Stack with
Elasticsearch, Kibana, Logstash, APM Server, Auditbeat, Metricbeat, Filebeat,
Packetbeat, and Heartbeat.

Point a browser at [`http://localhost:5601`](http://localhost:5601) to see the results.
