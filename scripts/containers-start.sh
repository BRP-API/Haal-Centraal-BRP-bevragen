#!/bin/bash

MODE=$1

if [ "$MODE" = "ci" ]; then
    docker compose -f .docker/db-ci.yml up -d
else
    docker compose -f .docker/db.yml up -d
fi
