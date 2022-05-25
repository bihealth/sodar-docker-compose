#!/bin/bash
# Development helper for running external components ONLY.
# SODAR server components are expected to be run locally on the host.
# You can also use the .sssd override if you need to develop with LDAP.
docker-compose -f docker-compose.dev.yml \
    -f docker-compose.override.yml.provided-cert \
    up
