#!/bin/bash

nswag run src/BrpService/Server.nswag /runtime:Net60
nswag run src/BrpProxy/DataTransferObjects.nswag /runtime:Net60
nswag run src/BrpProxy/GbaDataTransferObjects.nswag /runtime:Net60
