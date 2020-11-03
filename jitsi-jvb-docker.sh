#/bin/bash


if [ -z $1 ]; then
    echo "No argument entered."
    echo ""
    echo "To start Jitsi Jvb Docker:"
    echo ""
    echo "Ex: ./jitsi-jvb-docker.sh start" 
    echo ""
    echo "To stop Jitsi Jvb Docker:"
    echo ""
    echo "./jitsi-jvb-docker.sh stop"
    exit
fi

source config.sh

if [ "$1" == "start" ]; then

docker create   --name jitsi-jvb --cap-add SYS_ADMIN --cap-add NET_BIND_SERVICE   -e $DOCKER_HOST_ADDRESS -e $XMPP_AUTH_DOMAIN  -e $XMPP_INTERNAL_MUC_DOMAIN  -e $XMPP_SERVER  -e $JVB_AUTH_USER  -e $JVB_AUTH_PASSWORD -e $JVB_BREWERY_MUC -e $JVB_PORT -e $JVB_TCP_HARVESTER_DISABLED -e $JVB_TCP_PORT -e $JVB_TCP_MAPPED_PORT -e $JVB_STUN_SERVERS -e $JVB_ENABLE_APIS -e $JVB_WS_DOMAIN -e $JVB_WS_SERVER_ID -e $PUBLIC_URL -e $TZ -v ${CONFIG}/jvb:/config:Z -p ${JVB_PORT}:${JVB_PORT}/udp -p ${JVB_TCP_PORT}:${JVB_TCP_PORT}   --add-host  $ADD_HOST_IP ${jvbImage}


docker start jitsi-jvb

fi

if [ "$1" == "stop" ]; then
   
    docker rm --force jitsi-jvb
fi

if [ "$1" == "status" ]; then
   
    docker ps -f name=jitsi-jvb
 
fi
