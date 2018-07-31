# stack-docker
This example Docker Compose configuration demonstrates many components of the
Elastic Stack, all running on a single machine under Docker.

## Prerequisites
- Docker and Docker Compose.
  * Windows and Mac users get Compose installed automatically
with Docker for Windows/Mac.

  * Linux users can read the [install instructions](https://docs.docker.com/compose/install/#install-compose) or can install via pip:
```
pip install docker-compose
```

* Windows Users must set the following 2 ENV vars:
  * `COMPOSE_CONVERT_WINDOWS_PATHS=1`
  * `PWD=/path/to/checkout/for/stack-docker`
    * for example I use the path: `/c/Users/nick/elastic/stack-docker`
    * Note: you're paths must be in the form of `/c/path/to/place` using `C:\path\to\place` will not work
  * You can set these two ways:
    1. Temporarily add an env var in powershell use: `$Env:COMPOSE_CONVERT_WINDOWS_PATHS=1`
    2. Permanently add an env var in powershell use: `[Environment]::SetEnvironmentVariable("COMPOSE_CONVERT_WINDOWS_PATHS", "1", "Machine")`
      > Note: you will need to refresh or create a new powershell for this env var to take effect
    3. in System Properties add the environment variables.


* At least 4GiB of RAM for the containers. Windows and Mac users _must_
configure their Docker virtual machine to have more than the default 2 GiB of
RAM:

![Docker VM memory settings](screenshots/docker-vm-memory-settings.png)

* Linux Users must set the following configuration as `root`:

```
sysctl -w vm.max_map_count=262144
```
By default, the amount of Virtual Memory [is not enough](https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html).


## Starting the stack

First we need to:

1. set default password
2. create keystores to store passwords
3. install dashboards, index patterns, etc.. for beats and apm

This is accomplished using the setup.yml file:
```
docker-compose -f setup.yml up
```

Please take note after the setup completes it will output the password
that is used for the `elastic` login.

Now we can launch the stack with `docker-compose up -d` to create a demonstration Elastic Stack with
Elasticsearch, Kibana, Logstash, Auditbeat, Metricbeat, Filebeat, Packetbeat,
and Heartbeat.

Point a browser at [`http://localhost:5601`](http://localhost:5601) to see the results.
> *NOTE*: Elasticsearch is now setup with self-signed certs.

Log in with `elastic` and what ever your auto generated elastic password is from the
setup.
