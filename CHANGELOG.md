# SODAR Docker Compose Changelog

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
