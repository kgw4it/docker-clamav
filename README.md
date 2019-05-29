# docker-clamav for OpenShift

This repository is forked from the mko-x/docker-clamav.
The detailed information can be refered to o[riginal repository](https://github.com/mko-x/docker-clamav)
The Docker file is modified to adapt to OpenShift environment.

![ClamAV latest.stable](https://img.shields.io/badge/ClamAV-latest.stable-brightgreen.svg?style=flat-square)

# Optimized

Try the new alpine based version:
```bash
    docker run -d -p 3310:3310 mk0x/docker-clamav:alpine
```

Alpine version reduces foot print to something about 10%.

## Hub
Find new hub image at [hub.docker.com](https://hub.docker.com/r/mkodockx/docker-clamav)

## About
Dockerized open source antivirus daemons for use with 
- file sharing containers like [Nextcloud](https://hub.docker.com/_/nextcloud/) or 
- to use it via a [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) proxy like [@solita](https://github.com/solita) made [clamav-rest](https://github.com/solita/clamav-rest) or
- to directly connect to *clamav* via TCP port `3310`

## Description
ClamAV daemon as a Docker image. It *builds* with a current virus database and
*runs* `freshclam` in the background constantly updating the virus signature database. `clamd` itself
is listening on exposed port `3310`.

# Environment VARs

Thanks to @mchus proxy configuration is possible.

- HTTPProxyServer: Allows to set a proxy server
- HTTPProxyPort: Allows to set a proxy server port

## Releases
Find the latest releases at the official [docker hub](https://hub.docker.com/r/mk0x/docker-clamav) registry.

## Known Forks

- OpenShift support in [kuanfandevops fork](https://github.com/kuanfandevops/docker-clamav)

## Usage

### Debian Stretch Slim (default, :latest, :stretch-slim)
```bash
    docker run -d -p 3310:3310 mk0x/docker-clamav
```

### Alpine (:alpine)
```bash
    docker run -d -p 3310:3310 mk0x/docker-clamav:alpine
```

## Link
or linked (recommended)
```bash
    docker run -d --name av mk0x/docker-clamav(:alpine)
    docker run -d --link av:av application-with-clamdscan-or-something
```
    
## docker-compose

See example with Nextcloud at [docker-compose.yml](https://github.com/mko-x/docker-clamav/blob/master/docker-compose.yml).
