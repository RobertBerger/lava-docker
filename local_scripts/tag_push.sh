set -x
docker images
docker tag reslocal/lava-docker:latest reliableembeddedsystems/lava-docker:latest
docker images
docker login --username reliableembeddedsystems
docker push reliableembeddedsystems/lava-docker:latest
set +x
