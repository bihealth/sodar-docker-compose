#!/bin/bash
# Development helper for running external components with SSSD.
# SODAR server components are expected to be run locally on the host.
docker compose -f docker-compose.dev.yml \
    -f docker-compose.override.yml.provided-cert \
    -f docker-compose.override.yml.sssd \
    up \
    --remove-orphans
