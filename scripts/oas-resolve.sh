#!/bin/bash

npx --ignore-scripts redocly bundle ./specificatie/openapi-v1.yaml -o ./specificatie/resolved/openapi-v1.yaml
npx --ignore-scripts redocly bundle ./specificatie/openapi-v1.yaml -o ./specificatie/resolved/openapi-v1.json
npx --ignore-scripts redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.yaml
npx --ignore-scripts redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.json
