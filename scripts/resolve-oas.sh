#!/bin/bash

npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.yaml
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.json
npx redocly bundle ./specificatie/gba-openapi.yaml -o ./specificatie/gba-genereervariant/openapi.yaml
npx redocly bundle ./specificatie/gba-openapi.yaml -o ./specificatie/gba-genereervariant/openapi.json
