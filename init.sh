#!/bin/bash

mkdir -p volumes/{postgres/data,redis/data,traefik/letsencrypt,irods/{log,vault,vault-test}} \
    config/irods/{etc,etc-test} config/davrods/theme config/sodar/{samplesheets,templates} config/ldap
chown 1000:1000 volumes/irods/*
