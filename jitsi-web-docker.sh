#/bin/bash


if [ -z $1 ]; then
    echo "No argument entered."
    echo ""
    echo "To start Jitsi Web Docker:"
    echo ""
    echo "Ex: ./jitsi-web-docker.sh start" 
    echo ""
    echo "To stop Jitsi Web Docker:"
    echo ""
    echo "./jitsi-web-docker.sh stop"
    exit
fi

source config.sh

if [ "$1" == "start" ]; then

rm -rf ${CONFIG}/web

docker create   --name jitsi-web --cap-add SYS_ADMIN --cap-add NET_BIND_SERVICE  -e $ENABLE_LETSENCRYPT  -e $ENABLE_HTTP_REDIRECT  -e $DISABLE_HTTPS  -e $LETSENCRYPT_DOMAIN  -e $LETSENCRYPT_EMAIL  -e $PUBLIC_URL  -e $TZ  -e $AMPLITUDE_ID  -e $ANALYTICS_SCRIPT_URLS  -e $ANALYTICS_WHITELISTED_EVENTS  -e $BRIDGE_CHANNEL  -e $BRANDING_DATA_URL  -e $CALLSTATS_CUSTOM_SCRIPT_URL  -e $CALLSTATS_ID  -e $CALLSTATS_SECRET  -e $CHROME_EXTENSION_BANNER_JSON  -e $CONFCODE_URL  -e $CONFIG_BOSH_HOST  -e $CONFIG_EXTERNAL_CONNECT  -e $DEPLOYMENTINFO_ENVIRONMENT  -e $DEPLOYMENTINFO_ENVIRONMENT_TYPE  -e $DEPLOYMENTINFO_USERREGION  -e $DIALIN_NUMBERS_URL  -e $DIALOUT_AUTH_URL  -e $DIALOUT_CODES_URL  -e $DROPBOX_APPKEY  -e $DROPBOX_REDIRECT_URI  -e $ENABLE_AUDIO_PROCESSING  -e $ENABLE_AUTH  -e $ENABLE_CALENDAR  -e $ENABLE_FILE_RECORDING_SERVICE  -e $ENABLE_FILE_RECORDING_SERVICE_SHARING  -e $ENABLE_GUESTS  -e $ENABLE_IPV6  -e $ENABLE_LIPSYNC  -e $ENABLE_NO_AUDIO_DETECTION  -e $ENABLE_P2P  -e $ENABLE_PREJOIN_PAGE  -e $ENABLE_RECORDING  -e $ENABLE_REMB  -e $ENABLE_REQUIRE_DISPLAY_NAME  -e $ENABLE_SIMULCAST  -e $ENABLE_STATS_ID  -e $ENABLE_STEREO  -e $ENABLE_SUBDOMAINS  -e $ENABLE_TALK_WHILE_MUTED  -e $ENABLE_TCC  -e $ENABLE_TRANSCRIPTIONS  -e $ENABLE_WEBSOCKETS  -e $ETHERPAD_PUBLIC_URL  -e $ETHERPAD_URL_BASE  -e $GOOGLE_ANALYTICS_ID  -e $GOOGLE_API_APP_CLIENT_ID  -e $INVITE_SERVICE_URL  -e $JICOFO_AUTH_USER  -e $MATOMO_ENDPOINT  -e $MATOMO_SITE_ID  -e $MICROSOFT_API_APP_CLIENT_ID  -e $NGINX_RESOLVER  -e $PEOPLE_SEARCH_URL  -e $RESOLUTION  -e $RESOLUTION_MIN  -e $RESOLUTION_WIDTH  -e $RESOLUTION_WIDTH_MIN  -e $START_AUDIO_ONLY  -e $START_AUDIO_MUTED  -e $START_BITRATE  -e $START_VIDEO_MUTED  -e $TESTING_CAP_SCREENSHARE_BITRATE  -e $TESTING_OCTO_PROBABILITY  -e $XMPP_AUTH_DOMAIN  -e $XMPP_BOSH_URL_BASE  -e $XMPP_DOMAIN  -e $XMPP_GUEST_DOMAIN  -e $XMPP_MUC_DOMAIN  -e $XMPP_RECORDER_DOMAIN -v ${CONFIG}/web:/config:Z -v ${CONFIG}/web/letsencrypt:/etc/letsencrypt:Z -v ${CONFIG}/transcripts:/usr/share/jitsi-meet/transcripts:Z  -p ${HTTP_PORT}  -p ${HTTPS_PORT}  --add-host  $ADD_HOST_IP ${webImage}

mkdir -p ${CONFIG}/web/keys
cp cert.key cert.crt ${CONFIG}/web/keys

docker start jitsi-web


fi

if [ "$1" == "stop" ]; then
   
    docker rm --force jitsi-web
fi

if [ "$1" == "status" ]; then
   
    docker ps -f name=jitsi-web
 
fi
