IMAGE_NAME=$1
NETWORK_INTERFACE=$2

if [ $# -lt 2 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image> <network interface>" 
    echo "+ $0 reslocal/lava-docker docker0"
    echo "+ $0 reslocal/lava-docker br0"
    echo "+ $0 reslocal/lava-docker enp3s0"
    exit
fi

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=$1)"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a


echo "+ ID=\$(docker run -it ${IMAGE_NAME} /bin/cat /home/lava/bin/apikey.txt)"
echo "+ ========================>"
ID=$(docker run -it ${IMAGE_NAME} /bin/cat /home/lava/bin/apikey.txt)
echo "+ API key: ${ID}"
echo "+ <========================"

echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=$1)"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a


# ssh stuff:
#PORT=$(docker port ${ID} 22 | awk -F':' '{ print $2 }')
#IPADDR=$(ifconfig ${NETWORK_INTERFACE} | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
#echo "+ ssh to the container like this:"
#echo "ssh -X genius@${IPADDR} -p ${PORT}"

# let's attach to it:
#echo "+ docker attach ${ID}"
#docker attach ${ID}

