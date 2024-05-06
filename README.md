# docker-openwrt-build

## Description

This is a docker container needed for test and build OpenWRT images different versions. 

Officialy supperts the following versions:

1. OpenWRT 18.xx

1. OpenWRT 19.xx

1. OpenWRT 21.xx

1. OpenWRT 22.xx

1. OpenWRT 23.xx

## Software Requirements

* Only Linux. Windows isn't supported.

## Dependencies

* No external dependencies needed.

## Build and run

### Build and run by Dockerfile

```bash
# Build in detached mode
$ docker build -t docker-openwrt-build .

# Run in interactive mode
$ docker run -it docker-openwrt-build
```

## Usage by DockerHub

TBD

## FAQ

### How to change version of used gcc or g++

```bash
update-alternatives --set g++ /usr/bin/g++-9
update-alternatives --set gcc /usr/bin/gcc-9

update-alternatives --set g++ /usr/bin/g++-10
update-alternatives --set gcc /usr/bin/gcc-10

update-alternatives --set g++ /usr/bin/g++-11
update-alternatives --set gcc /usr/bin/gcc-11
```