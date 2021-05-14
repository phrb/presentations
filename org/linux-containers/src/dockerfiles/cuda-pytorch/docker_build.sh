#! /bin/bash

set -e

function usage() {
    echo "Usage: ./docker_build.sh [OPTION]"
    echo "  -b, --build       Builds the docker image"
    echo "  -r, --run         Starts a container, gets a shell"
    echo "  -l, --launch      Launches a container, gets a shell"
    echo "  -c, --configure   Configure repository for experiments"
    echo "  --help            Print this message"
    exit 0
}

if [ $# -eq 0 ] ; then
    usage
fi

PROXY_URL=http://web-proxy-pa.labs.hpecorp.net:8088/
REPO_SRC_DIR=/home/bruelp/haq-release
REPO_TARGET_DIR=/haq-release
SRC_DIR=/shared/bruelp/imagenet
TARGET_DIR=/haq-release/data
IMAGE=haq-sampling:latest
CONTAINER=haq-test

while test $# -gt 0
do
    case "$1" in
        -b|--build)
            sudo docker build \
                 -t haq-sampling:latest \
                 --build-arg=http_proxy=$PROXY_URL \
                 --build-arg=https_proxy=$PROXY_URL .
            ;;
        -r|--run)
            sudo docker run -d \
                 --gpus all \
                 --ipc=host \
                 -it \
                 --name $CONTAINER \
                 --mount type=bind,source=$SRC_DIR,target=$TARGET_DIR \
                 --mount type=bind,source=$REPO_SRC_DIR,target=$REPO_TARGET_DIR \
                 $IMAGE
            sudo docker exec -it $CONTAINER /bin/bash
            ;;
        -rr|--random-run)
            NAME=$CONTAINER-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)
            sudo docker run -d \
                 --gpus all \
                 --ipc=host \
                 -it \
                 --name $NAME \
                 --mount type=bind,source=$SRC_DIR,target=$TARGET_DIR \
                 --mount type=bind,source=$REPO_SRC_DIR,target=$REPO_TARGET_DIR \
                 $IMAGE
            sudo docker exec -it $NAME /bin/bash
            ;;
        -l|--launch)
            sudo docker exec -it $CONTAINER /bin/bash
            ;;
        -s|--stop)
            sudo docker container stop $CONTAINER
            ;;
        -rm|--remove)
            sudo docker container rm $CONTAINER
            ;;
        -p|--pull)
            git pull
            ;;
        --help|*)
            usage
            ;;
    esac
    shift
done

exit 0
