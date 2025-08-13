#!/bin/bash

MODE=$1

if [ "$MODE" = "ci" ]; then
    docker compose -f .docker/db-ci.yml down
else
    docker compose -f .docker/db.yml down
fi

docker compose \
    -f .docker/identityserver.yml \
    -f .docker/gezag-api.yml \
    -f .docker/personen-data-service.yml \
    -f .docker/personen-informatie-service.yml \
    -f .docker/autorisatie-protocollering-proxy.yml \
    down
