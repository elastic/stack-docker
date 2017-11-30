#!/bin/bash

set -euo pipefail

beat=$1

sleep ${SLEEP_TIME}

until ${beat} setup -E setup.kibana.host=kibana
do
    sleep 2
    echo Retrying...
done
