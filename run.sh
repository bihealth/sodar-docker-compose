#!/bin/bash

docker-compose -f docker-compose.yml \
    -f docker-compose.override.yml.irods \
    -f docker-compose.override.yml.davrods \
    -f docker-compose.override.yml.provided-cert \
    up \
    --remove-orphans
