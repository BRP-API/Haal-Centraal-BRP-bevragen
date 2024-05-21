#!/bin/bash

npx nswag run src/BrpService/Server.nswag
npx nswag run src/BrpProxy/DataTransferObjects.nswag
npx nswag run src/BrpProxy/GbaDataTransferObjects.nswag
