#/bin/bash


if [ -z $1 ]; then
    echo "No argument entered."
    echo ""
    echo "To start Jitsi Jicofo Docker:"
    echo ""
    echo "Ex: ./jitsi-jicofo-docker.sh start" 
    echo ""
    echo "To stop Jitsi Jicofo Docker:"
    echo ""
    echo "./jitsi-jicofo-docker.sh stop"
    exit
fi

source config.sh

if [ "$1" == "start" ]; then

docker create   --name jitsi-jicofo --cap-add SYS_ADMIN --cap-add NET_BIND_SERVICE   -e $AUTH_TYPE -e $ENABLE_AUTH -e $XMPP_DOMAIN -e $XMPP_AUTH_DOMAIN -e $XMPP_INTERNAL_MUC_DOMAIN -e $XMPP_MUC_DOMAIN -e $XMPP_SERVER -e $JICOFO_COMPONENT_SECRET -e $JICOFO_AUTH_USER -e $JICOFO_AUTH_PASSWORD -e $JICOFO_RESERVATION_REST_BASE_URL -e $JVB_BREWERY_MUC -e $JIGASI_BREWERY_MUC -e $JIGASI_SIP_URI -e $JIBRI_BREWERY_MUC -e $JIBRI_PENDING_TIMEOUT -e $TZ -v ${CONFIG}/jicofo:/config:Z   --add-host  $ADD_HOST_IP ${jicofoImage}


docker start jitsi-jicofo
docker update --restart always jitsi-jicofo

fi

if [ "$1" == "stop" ]; then
   
    docker rm --force jitsi-jicofo
fi

if [ "$1" == "status" ]; then
   
    docker ps -f name=jitsi-jicofo
 
fi
