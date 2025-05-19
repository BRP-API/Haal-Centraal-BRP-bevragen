#!/bin/bash

npx redocly bundle ./specificatie/openapi-v1.yaml -o ./specificatie/resolved/openapi-v1.yaml
npx redocly bundle ./specificatie/openapi-v1.yaml -o ./specificatie/resolved/openapi-v1.json
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.yaml
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.json
