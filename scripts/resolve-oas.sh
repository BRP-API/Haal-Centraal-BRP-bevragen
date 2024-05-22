#!/bin/bash

redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.yaml
redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.json
redocly bundle ./specificatie/gba-openapi.yaml -o ./specificatie/gba-genereervariant/openapi.yaml
redocly bundle ./specificatie/gba-openapi.yaml -o ./specificatie/gba-genereervariant/openapi.json
