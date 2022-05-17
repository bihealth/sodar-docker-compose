# Run SODAR Server using Docker Compose

This repository provides a Docker Compose network with all the components needed for running [SODAR](https://github.org/bihealth/sodar-server) (System for Omics Data Access and Retrieval).

Detailed documentation regarding configuring and deploying the system can be found in the "SODAR Administraion" section of the [SODAR Manual](https://sodar-server.readthedocs.io/en/latest/admin_overview.html).

> - :interrobang: Questions? Need Help?
>   SODAR is academic software but we are happy to provide support on a best-effort manner.
>   Use the [issue tracker](https://github.com/bihealth/sodar-docker-compose/issues) or send an email to cubi-helpdesk@bihealth.de in case of any problems.
> - :factory: Bringing SODAR into "production"?
>   Feel free to contact us via cubi-helpdesk@bihealth.de in the case that you want to use SODAR beyond an evaluation.
>   We will try to assist you in your setup on a best-effort manner.


## Prerequisites

- Hardware
    - ~10 GB of disk space for the Docker images
- Operating System
    - A modern Linux distribution that is [supported by Docker](https://docs.docker.com/engine/install/#server)
    - Outgoing HTTPS connections to the internet are allowed to download data and Docker images
    - Server ports 80 and 443 are open and free on the host
- Software
    - [Docker](https://docs.docker.com/get-docker/)
    - [Docker Compose](https://docs.docker.com/compose/install/)
    - [OpenSSL](https://www.openssl.org/)


## Quickstart

This section provides quickstart introductions to test or evaluate the SODAR system on your Linux workstation.

### 1. Get Scripts and Configuration

First, clone this repository.

```bash
$ git clone https://github.com/bihealth/sodar-docker-compose.git
$ cd sodar-docker-compose
```

Alternatively, fork the repository as a first step so you can track changes that you make using Git.

### 2. Update /etc/hosts

Edit the `/etc/hosts` file and add the following line:

```bash
$ sudo vi /etc/hosts

127.0.0.1 sodar.local
```

This is needed as certain SODAR features require a fully qualified domain name for the host.

### 3. Initialize Volumes and Set the Environment

Use the provided `init.sh` script for creating the required volumes (directories).

```bash
$ bash init.sh
$ ls volumes/
irods  postgres  redis  traefik
```

Next, copy the example environment file `env.example` to `.env`.

```bash
$ cp env.example .env
```

For the default evaluation setup, no edits to the environment are required Later, you can edit this file to configure your SODAR installation.

### 4. Provide Certificate and DH Parameters

To enable all SODAR features, HTTPS connections are required. For evaluation you can use self-signed certificates. For instructions on how to generate certificates with OpenSSL in Ubuntu, see [here](https://ubuntu.com/server/docs/security-certificates). If using a different Linux distribution, consult the relevant documentation.

Once you have generated the required `.crt` and `.key` files, copy them into `config/traefik/tls`.

```bash
$ cp yourcert.crt config/traefik/tls/server.crt
$ cp yourcert.key config/traefik/tls/server.key
```

iRODS also excepts a `dhparams.pem` file for Diffie-Hellman key exchange. For basic evaluation of SODAR this step is not critical, as the file being missing will only result in error messages in the iRODS server log as it falls back to built-in values. For production use of SODAR, generating your own file is strongly recommended.

You can generate the file using OpenSSL as demonstrated below. This will take some time.

```bash
$ openssl dhparam -2 -out config/irods/etc/dhparams.pem 2048
```

### 5. Bring Up the System

You can now bring up the system with Docker Compose.

The provided `run.sh` script runs all the necessary overrides for a full SODAR
system running in the Docker network. It will create a lot of output and will not return to your shell. You can stop the servers with `Ctrl-C`.

```bash
$ ./run.sh
```

In the case of any error please report it to us via the Issue Tracker of this repository or email to `cubi-helpdesk@bihealth.de`. Please include the full output as a text file attachment.

### 6. Create Superuser Account

To gain access to the SODAR web UI, you must first create a superuser account. The user name should be given as `root`, otherwise you will need to edit the `.env` file. Open a new terminal tab, enter the following and follow the prompt:

```bash
$ docker exec -it sodar-docker-compose_sodar-web_1 python /usr/src/app/manage.py createsuperuser --skip-checks --username root
```

### 7. Use SODAR

You can now navigate to the SODAR website at `https://sodar.local/` on your web browser. Please note that SODAR officially supports the Mozilla Firefox and Google Chrome browsers.

The browser will warn you about self-signed certificates and you will need to allow access according to the browser's instructions.

Once the site has loaded, login with the account `root` and the password you provided in the previous step.

Typically, the first step when logging to a newly installed SODAR site is to create a top level category under which projects can be added. You can also add additional users in the Django Admin, which is available from the user dropdown in the top right corner of the UI.

For further instruction on using SODAR, please consul the [SODAR Manual](https://sodar-server.readthedocs.io/en/latest/).


## Anatomy of this Repository

- The file `init.sh` performs some initialization to be done before starting the containers.
- The file `docker-compose.yml` contains the definition of the services required to run SODAR Server.
- The `config` directory contains files that are used for configuration:
    - `config/traefik/certificates.toml` -- configuration for SSL/TLS setup
        - `/etc/traefik/tls/server.crt` and `server.key` -- place the SSL certificate and unencrypted private key here for custom SSL certificates
        - in the case of certificates from DFN (used by many German academic organizations), you will have to provide the full chain to the "Telekom" certificate in `server.crt`.

```bash
$ tree
.
├── config
│   ├── exomiser
│   │   └── application.properties
│   ├── postgres
│   │   └── postgresql.conf.orig
│   └── traefik
│       ├── certificates.toml
│       └── ssl
│           └── PLACE_TLS_FILES_HERE
├── docker-compose.yml
├── LICENSE
├── README.md
└── init.sh
```

## Maintainer Info

This section section is only interesting for maintainers of `sodar-docker-compose`.

Install the Github CLI ([see instructions](https://github.com/cli/cli#installation)), then login with `gh auth login`.

### Creating a New Release

Use `${sodar-server-version}-${build-version}` as the tag name for `sodar-docker-compose`.
This allows people to easily track if something changed here but the `sodar-server` version is the same.

1. Create a new entry in `HISTORY.md` and commit.
2. Create a new tag: `make tag TAG=vxx`.
3. Push the tag and release: `make release`.
