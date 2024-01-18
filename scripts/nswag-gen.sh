#!/bin/bash

nswag run src/BrpService/Server.nswag
nswag run src/BrpProxy/DataTransferObjects.nswag
nswag run src/BrpProxy/GbaDataTransferObjects.nswag
