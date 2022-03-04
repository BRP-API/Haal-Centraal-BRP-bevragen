#!/bin/bash

java -jar swagger-codegen-cli.jar generate -i ./specificatie/openapi.yaml -l openapi-yaml -o ./specificatie/genereervariant
java -jar swagger-codegen-cli.jar generate -i ./specificatie/openapi.yaml -l openapi -o ./specificatie/genereervariant
java -jar swagger-codegen-cli.jar generate -i ./specificatie/gba-openapi.yaml -l openapi-yaml -o ./specificatie/gba-genereervariant
java -jar swagger-codegen-cli.jar generate -i ./specificatie/gba-openapi.yaml -l openapi -o ./specificatie/gba-genereervariant
