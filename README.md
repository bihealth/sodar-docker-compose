# Run SODAR Server using Docker Compose

This repository provides a Docker Compose network with all the components needed for running [SODAR](https://github.com/bihealth/sodar-server) (System for Omics Data Access and Retrieval).

Detailed documentation regarding configuring and deploying the system can be found in the "SODAR Administration" section of the [SODAR manual](https://sodar-server.readthedocs.io/en/latest/admin_overview.html).

> - :interrobang: Questions? Need Help?
>   SODAR is academic software but we are happy to provide support on a best-effort manner.
>   Use the [issue tracker](https://github.com/bihealth/sodar-docker-compose/issues) or send an email to cubi-helpdesk@bihealth.de in case of any problems.
> - :factory: Bringing SODAR into production?
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


## Quickstart for Evaluation

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
irods  postgres  redis  sodar   traefik
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

To gain access to the SODAR web UI, you must first create a superuser account. The user name should be given as `admin`, otherwise you will need to edit the `.env` file. Open a new terminal tab, enter the following and follow the prompt:

```bash
$ docker exec -it sodar-docker-compose_sodar-web_1 python /usr/src/app/manage.py createsuperuser --skip-checks --username admin
```

### 7. Use SODAR

You can now navigate to the SODAR website at `https://sodar.local/` on your web browser. Please note that SODAR officially supports the Mozilla Firefox and Google Chrome browsers.

The browser will warn you about self-signed certificates and you will need to allow access according to the browser's instructions.

Once the site has loaded, login with the account `admin` and the password you provided in the previous step.

Typically, the first step when logging to a newly installed SODAR site is to create a top level category under which projects can be added. You can also add additional users in the Django Admin, which is available from the user dropdown in the top right corner of the UI.

For further instruction on using SODAR, please consult the [SODAR Manual](https://sodar-server.readthedocs.io/en/latest/).


## Run in Development

This repository can also be used to run external SODAR components when developing the main `sodar-server` project.

In this case, the SODAR server itself, consisting of `sodar-web`, `sodar-celeryd-default` and `sodar-celerybeat` will be run locally on the development workstation, while the databases, iRODS and Davrods are run in the Docker Compose network.

For full instructions on how to set up the dev environment, see the development section in the [SODAR manual](https://sodar-server.readthedocs.io/en/latest/).

Instructions in brief:

1. Clone this repository in a new directory, e.g. `sodar-docker-compose-dev`
2. Run `./init.sh`
3. Provide your self-signed certificate and DH params as instructed in the quickstart section
4. Copy `env.example.dev` into `.env`
5. Run `./run_dev.sh`
6. Configure and run the required SODAR server components locally on your workstation


## Troubleshooting

Solutions for common problems with running the environment are detailed in this subsection.

### Conflicts with Existing Database Servers

If you are already running Postgres, Redis or iRODS on your workstation in their default ports, these servers will fail
to run in the Docker Compose network. To fix this you should either:

- Temporarily shut down your existing server
- Or, alter the forwarded ports and your environment file to connect to separate ports
- Or, remove the servers from the Docker Compose network and use your existing development servers.

**NOTE:** You should never use an existing iRODS server as the "test" iRODS server, as the server zone and users will get wiped out after each SODAR test!


## Maintainer Info

This section section is only interesting for maintainers of `sodar-docker-compose`.

Install the Github CLI ([see instructions](https://github.com/cli/cli#installation)), then login with `gh auth login`.

### Creating a New Release

Use `${sodar-server-version}-${build-version}` as the tag name for `sodar-docker-compose`.
This allows people to easily track if something changed here but the `sodar-server` version is the same.

1. Create a new entry in `CHANGELOG.md` and commit.
2. Create a new tag: `make tag TAG=vxx`.
3. Push the tag and release: `make release`.
