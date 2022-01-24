#!/bin/bash

mkdir -p volumes/{postgres/data,redis/data,traefik/letsencrypt,irods/{log,vault}} config/irods/etc config/davrods/theme
chown 1000:1000 volumes/irods/*
