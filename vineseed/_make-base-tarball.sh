#!/bin/bash -x

set -e

CONTAINER_NAME=${CONTAINER_NAME:-build-vlseed-min} # $(uuidgen)
DOCKER_VINESEED=${DOCKER_VINESEED:-munepi/vineseed} # local/vineseed

target_image=VineSeed_x86_64-docker-$(date +%Y%m%d).tar.xz

trap _stop_docker_container EXIT
_stop_docker_container() {
    docker stop ${CONTAINER_NAME} ||:
    docker container rm --force ${CONTAINER_NAME} ||:
    echo "$(basename $0): done."
}


## First, make a minimal container based on local/vineseed
docker run -it --detach --name ${CONTAINER_NAME} \
       -e SUDO_USER=root -e USERHELPER_UID=0  ${DOCKER_VINESEED}
# docker start ${CONTAINER_NAME}

## build VineSeed base image via vbuilder
docker exec -it ${CONTAINER_NAME}  \
       /bin/bash -c "apt update && \\
           apt -y install tar xz vbootstrap && \\
           vbuilder --version VineSeed --no-build-essential build"

## removed unpacked files
docker exec -it ${CONTAINER_NAME}  \
       /bin/bash -c 'rm -f /var/local/vbootstrap/VineSeed_x86_64/var/cache/apt/archives/*.rpm'
docker exec -it \
       -w /var/local/vbootstrap/VineSeed_x86_64  ${CONTAINER_NAME}  \
       /bin/bash -c "mkdir -p ./usr/share/locale_temp && \\
           mv ./usr/share/locale/en* ./usr/share/locale/ja ./usr/share/locale/locale.alias  ./usr/share/locale_temp/ && \\
           rm -rf ./usr/share/locale/* && \\
           mv ./usr/share/locale_temp/* ./usr/share/locale/ && \\
           rm -rf ./usr/share/locale_temp"
docker exec -it \
       -w /var/local/vbootstrap/VineSeed_x86_64  ${CONTAINER_NAME}  \
       /bin/bash -c 'rm -rf ./usr/share/doc/*'

## make the target image
docker exec -it ${CONTAINER_NAME}  \
       /bin/bash -c "tar -C /var/local/vbootstrap/VineSeed_x86_64 -cf - . | \\
            xz -9 >/var/local/vbootstrap/${target_image}"

## Finally, copy the target image to the host
docker cp ${CONTAINER_NAME}:/var/local/vbootstrap/${target_image} .

exit
