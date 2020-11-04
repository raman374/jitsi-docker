#/bin/bash


if [ -z $1 ]; then
    echo "No argument entered."
    echo ""
    echo "To start Jitsi Jibri Docker:"
    echo ""
    echo "Ex: ./jitsi-jibri-docker.sh start" 
    echo ""
    echo "To stop Jitsi Jibri Docker:"
    echo ""
    echo "./jitsi-jibri-docker.sh stop"
    exit
fi

source config.sh

if [ "$1" == "start" ]; then

rm -rf ${CONFIG}/jibri

docker create   --name jitsi-jibri --cap-add SYS_ADMIN --cap-add NET_BIND_SERVICE  -e $XMPP_AUTH_DOMAIN -e $XMPP_INTERNAL_MUC_DOMAIN -e $XMPP_RECORDER_DOMAIN -e $XMPP_SERVER -e $XMPP_DOMAIN -e $JIBRI_XMPP_USER -e $JIBRI_XMPP_PASSWORD -e $JIBRI_BREWERY_MUC -e $JIBRI_RECORDER_USER -e $JIBRI_RECORDER_PASSWORD -e $JIBRI_RECORDING_DIR -e $JIBRI_FINALIZE_RECORDING_SCRIPT_PATH -e $JIBRI_STRIP_DOMAIN_JID -e $JIBRI_LOGS_DIR -e $DISPLAY -v ${CONFIG}/jibri:/config -v /dev/shm:/dev/shm -v recording.sh:/config/recording.sh  --device /dev/snd:/dev/snd   --add-host  $ADD_HOST_IP $jibriImage


docker start jitsi-jibri
docker update --restart always jitsi-jibri

fi

if [ "$1" == "stop" ]; then
   
    docker rm --force jitsi-jibri
fi

if [ "$1" == "status" ]; then
   
    docker ps -f name=jitsi-jibri
 
fi
