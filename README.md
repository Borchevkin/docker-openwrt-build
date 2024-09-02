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

For your convinience may be used several approaches for run a container with image

### Build and run - Dockerfile

This approach assume that you want to build image locally from Dockerfile using the following commands:

```bash
# Build in detached mode
docker build -t docker-openwrt-build .

# Run in interactive mode
docker run -it --name openwrt-build_container docker-openwrt-build
```

### Build and run - DockerHub

This approach assume that you can get actual image through Docker Hub using the following commands:

```bash
# Pull the image wit desired version
docker image pull borchevkin/openwrt-build:1.0.0

# Run the image in interactive mode
docker run -it --name openwrt-build_container borchevkin/openwrt-build:1.0.0
```

## OpenWRT retention

When using this docker image for build sometimes (actually always for speed up builds) will be better to mount folder and clone and build OpenWRT on your host machine. 

For this you can use several approaches.

### OpenWRT retention - Docker Compose

As example, you can create ```docker-compose.yml``` with the similar configuration:

```yml
version: "3.9"
services:
  builder:
    build: .
    volumes:
      - type: bind
        source: ./
        target: /host
      - type: bind
        source: ~/.ssh
        target: /root/.ssh
    working_dir: /host
    tty: true
```

You can run composer with the following command:

```bash
docker compose up
```

### OpenWRT retention - Run the docker container with options and SSH support

As example, run a container with the following options:

```bash
docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/known_hosts:/root/.ssh/known_hosts -v "$PWD":/host -w /host -d -i -t --name docker-openwrt-build_container docker-openwrt-build
```

## FAQ

### FAQ - How to detach from running container without stop it

Press on keyboard sequentally ```Ctrl+P Ctrl+Q```.

### FAQ - How to change version of used gcc or g++

```bash
# Or
update-alternatives --set g++ /usr/bin/g++-9
update-alternatives --set gcc /usr/bin/gcc-9

# Or
update-alternatives --set g++ /usr/bin/g++-10
update-alternatives --set gcc /usr/bin/gcc-10

# Or
update-alternatives --set g++ /usr/bin/g++-11
update-alternatives --set gcc /usr/bin/gcc-11
```

### FAQ - python not found

Use the following:

```bash
python3 -v
python2.7 -v
```

### FAQ - Cannot ls a host dir inside Docker container (RHEL-based)

```bash
sudo su -c "setenforce 0"
```

## For maintaners

### For maintainers - push new version to Docker hub
rm 
```bash
# Get container ID and commit it
docker container ls

docker container commit 5d1aec6c387d openwrt-build:latest


```
