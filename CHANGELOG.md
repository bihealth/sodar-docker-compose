# SODAR Docker Compose Changelog

## v1.1-1 (2025-05-23)

- Add SODAR v1.1 env vars (#86)
- Add `IRODS_HASH_SCHEME` env var (#88)


## v1.0.0-1 (2025-03-03)

- Add SODAR v1.0 env vars (#59, #82)
- Add `run_dev_sssd.sh` script (#65)
- Add `offline_credentials_expiration` to example SSSD config (#64)
- Add LDAP TLS instructions to README (#58)
- Add `IRODS_PASSWORD_MIN_TIME` env var (#66, #70)
- Update postgres to suppress iRODS transaction warnings (#17)
- Update LDAP TLS config to be mounted as directory (#49)
- Upgrade to Postgres v16 (#34)
- Upgrade to `irods-docker` v4.3.3-2 (#34, #79)
- Upgrade to `davrods-docker` v4.3.3_1.5.1-1 (#63)
- Remove deprecated version strings (#67)
- Remove `SODAR_ENABLE_SENTRY` from `env.example.dev` (#76)
- Remove `IRODS_AUTHENTICATION_SCHEME` env var (#77)


## v0.15.1-1 (2024-09-12)

- Release for SODAR v0.15.1


## v0.15.0-1 (2024-08-08)

- Add `SODAR_ISATEMPLATES_ENABLE_CUBI_TEMPLATES` env var (#54)
- Add `isatemplates_backend` to `ENABLED_BACKEND_PLUGINS` in `env.example` (#54)


## v0.14.2-1 (2024-03-15)

- Add `TASKFLOW_IRODS_CONN_TIMEOUT` env var (#53)


## v0.14.1-1 (2024-01-02)

- Fix SSSD override LDAP cert binding (#44)
- Update `docker compose` command in scripts (#45)
- Add `NETWORK_BRIDGE_NAME` env var (#46)
- Add `SODAR_LDAP_DEBUG` env var (#50)
- Replace dummy LDAP cert with `.gitignore` file (#51)


## v0.14.0-1 (2023-09-27)

- Add TLS and support and user filter support in LDAP settings
- Add LDAP CA cert support
- Add `SODAR_ADMINS` env var (#41)


## v0.13.3-1 (2023-05-10)

- Release for SODAR v0.13.3


## v0.13.2-1 (2023-04-18)

- Release for SODAR v0.13.2


## v0.13.1-1 (2023-03-31)

- Release for SODAR v0.13.1
- Add `SODAR_LANDINGZONES_DISABLE_FOR_USERS` env var (#37)


## v0.13.0-1 (2023-02-08)

- Release for SODAR v0.13.0
- Increase `shm_size` on postgres (#33)
- Add `SODAR_LDAP_ALT_DOMAINS` env var (#35)
- Add `SODAR_SHEETS_IGV_OMIT_*` env vars (#36)


## v0.12.1-1 (2022-11-10)

- Release for SODAR v0.12.1


## v0.12.0-2 (2022-10-28)

- Add missing `REDIS_URL` env var (#30)


## v0.12.0-1 (2022-10-26)

- Release for SODAR v0.12.0
- Remove dedicated SODAR Taskflow image (#24)
- Update Taskflow-related environment variables (#24, #27)
- Fix duplicate lines in lets-encrypt override (#21)
- Set bridge network name manually (#26)
- Add SODAR config directories to volumes (#18)


## v0.11.3-1 (2022-08-30)

- First release of sodar-docker-compose, compatible with SODAR v0.11.3
