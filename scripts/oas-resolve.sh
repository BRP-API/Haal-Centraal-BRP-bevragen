#!/bin/bash

npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.yaml
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/resolved/openapi.json
