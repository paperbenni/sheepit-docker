#!/bin/bash
ls /sheep || mkdir /sheep
cd /sheep

source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb heroku
pb heroku/title

if isheroku; then
    herokutitle "sheepit" "active"
    sleep 1
fi

#Check for updates
echo Checking for client updates...
latestVersion=$(curl --silent --head https://www.sheepit-renderfarm.com/media/applet/client-latest.php | grep -Po 'Content-Disposition:.*filename="?\Ksheepit-client-[\d\.]+')

if [ ! -e sheepit.jar ]; then
    echo Updating client...
    rm -f sheepit-client*.jar
    #Download new client.
    curl https://www.sheepit-renderfarm.com/media/applet/client-latest.php -o sheepit.jar
fi

echo Autodetected $(nproc) cores.
cpu=$(nproc)

SHEEPNAME=${user_name:-paperbenni}
SHEEPASS=${user_password:-sheepit123}

echo Starting client.
java -jar /sheep/sheepit.jar -ui text -login $SHEEPNAME -password $SHEEPASS -cores $cpu -cache-dir /sheep/cache
