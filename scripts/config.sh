#!/bin/bash

# Fail fast, including pipelines
set -e -o pipefail

function redis_hosts() {
    local host=${REDIS_HOSTS}
    echo "$host"
}

function is_cluster() {
    local is_cluster=false

    if [ "$(redis_hosts)" = "127.0.0.1" ] ; then
        is_cluster=true
    fi

    echo "$is_cluster"
}

if [[ -z "$(redis_hosts)" ]]; then
    echo "A list of redis hosts is required." >&2
    exit 1
fi
