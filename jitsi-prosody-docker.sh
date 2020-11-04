#/bin/bash


if [ -z $1 ]; then
    echo "No argument entered."
    echo ""
    echo "To start Jitsi prosody Docker:"
    echo ""
    echo "Ex: ./jitsi-prosody-docker.sh start" 
    echo ""
    echo "To stop Jitsi prosody Docker:"
    echo ""
    echo "./jitsi-prosody-docker.sh stop"
    exit
fi

source config.sh

 if [ "$1" == "start" ]; then
   

docker create   --name jitsi-prosody --cap-add SYS_ADMIN --cap-add NET_BIND_SERVICE  -e $AUTH_TYPE -e $ENABLE_AUTH -e $ENABLE_GUESTS -e $ENABLE_LOBBY  -e $GLOBAL_MODULES -e $GLOBAL_CONFIG -e $LDAP_URL -e $LDAP_BASE -e $LDAP_BINDDN -e $LDAP_BINDPW -e $LDAP_FILTER -e $LDAP_AUTH_METHOD -e $LDAP_VERSION -e $LDAP_USE_TLS -e $LDAP_TLS_CIPHERS -e $LDAP_TLS_CHECK_PEER -e $LDAP_TLS_CACERT_FILE -e $LDAP_TLS_CACERT_DIR -e $LDAP_START_TLS -e $XMPP_DOMAIN -e $XMPP_AUTH_DOMAIN -e $XMPP_GUEST_DOMAIN -e $XMPP_MUC_DOMAIN -e $XMPP_INTERNAL_MUC_DOMAIN -e $XMPP_MODULES -e $XMPP_MUC_MODULES -e $XMPP_INTERNAL_MUC_MODULES -e $XMPP_RECORDER_DOMAIN -e $JICOFO_COMPONENT_SECRET -e $JICOFO_AUTH_USER -e $JICOFO_AUTH_PASSWORD -e $JVB_AUTH_USER -e $JVB_AUTH_PASSWORD -e $JIGASI_XMPP_USER -e $JIGASI_XMPP_PASSWORD -e $JIBRI_XMPP_USER -e $JIBRI_XMPP_PASSWORD -e $JIBRI_RECORDER_USER -e $JIBRI_RECORDER_PASSWORD -e $JWT_APP_ID -e $JWT_APP_SECRET -e $JWT_ACCEPTED_ISSUERS -e $JWT_ACCEPTED_AUDIENCES -e $JWT_ASAP_KEYSERVER -e $JWT_ALLOW_EMPTY -e $JWT_AUTH_TYPE -e $JWT_TOKEN_AUTH_MODULE -e $LOG_LEVEL -e $PUBLIC_URL -e $TZ -v ${CONFIG}/prosody/config:/config:Z -v ${CONFIG}/prosody/prosody-plugins-custom:/prosody-plugins-custom:Z -v ${CONFIG}/transcripts:/usr/share/jitsi-meet/transcripts:Z  -p 5222:5222  -p 5347:5347 -p 5280:5280  --add-host  $ADD_HOST_IP ${prosodyImage}


docker start jitsi-prosody
docker update --restart always jitsi-prosody

fi

if [ "$1" == "stop" ]; then
   
    docker rm --force jitsi-prosody
fi

if [ "$1" == "status" ]; then
   
    docker ps -f name=jitsi-prosody
 
fi
