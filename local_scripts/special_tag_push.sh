if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "./special_tag_push.sh <tag>"
    exit
fi

set -x
docker images
docker tag reslocal/lava-docker:latest reliableembeddedsystems/lava-docker:$1
docker images
docker login --username reliableembeddedsystems
docker push reliableembeddedsystems/lava-docker:$1
set +x
