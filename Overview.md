# Supported tags and respective `Dockerfile` links
* [`latest`, `20201216`  (munepi/docker-vinelinux/Dockerfile)](https://github.com/munepi/docker-vinelinux/blob/20201216/vineseed/Dockerfile)
* [`20200823`  (munepi/docker-vinelinux/Dockerfile)](https://github.com/munepi/docker-vinelinux/blob/20200823/vineseed/Dockerfile)
* [`20190607`  (munepi/docker-vinelinux/Dockerfile)](https://github.com/munepi/docker-vinelinux/blob/20190607/vineseed/Dockerfile)
* [`20190602`  (munepi/docker-vinelinux/Dockerfile)](https://github.com/munepi/docker-vinelinux/blob/20190602/vineseed/Dockerfile)

# What is VineSeed?
VineSeed is a rolling development snapshot version of the Vine Linux distribution containing the latest packages that have been introduced into Vine Linux.
This repository provides an **unofficial** base image of VineSeed x86_64. 

 * [Vine Linux Official Website](https://vinelinux.org/) (in Japanese)
 * [Brief Introduction to Vine Linux for non-Japanese people](https://vinelinux.org/vlmagazine/20110617.html) (in English)

<!-- ![](https://vinelinux.org/images/vinelinux-logo.png) -->

# About this image
The `munepi/vineseed:latest` tag will always point the latest unstable snapshot. 

# How It's Made
The base tarballs for this image are built using the reproducible Vine Linux bootstrap tool, [vbootstrap](http://trac.vinelinux.org/wiki/VineBootstrap). 
Indeed, the scripts in [github.com/munepi/docker-vinelinux](https://github.com/munepi/docker-vinelinux.git) are used to (re-)generate the latest (same) tarballs below.

1. Pull the Docker image `munepi/vineseed:latest`.
``` shell
$ docker pull munepi/vineseed
```
2. Clone the Git repository `munepi/docker-vinelinux` from GitHub
``` shell
$ git clone https://github.com/munepi/docker-vinelinux.git
```
3. Generate the latest snapshot tarball of VineSeed.
``` shell
$ cd docker-vinelinux
$ make vineseed/VineSeed_x86_64-docker-snapshot.tar.xz
```
4. Build the latest local Docker image `local/vineseed` of Vineseed. 
``` shell
$ make local/vineseed
```

# License
View [license information (Vine Linux General Public License 4.0 via Vine Linux Official Website)](https://vinelinux.org/docs/vine6/VLGPL/vine-vlgpl.html) for the software contained in this image.
