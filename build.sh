#!/bin/bash

CMDNAME=`basename $0`
while getopts :pb: OPT
do
  case $OPT in
    "p" ) FLG_P="TRUE" ;;
    "b" ) FLG_B="TRUE" ; VALUE_B="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-p] [-b VALUE]" 1>&2
          exit 1 ;;
  esac
done

if [ "$FLG_B" = "TRUE" ]; then
  echo '"-b"オプションが指定されました。 '
  echo "→値は$VALUE_Bです。"
fi

cd `dirname $0`
if [ "$FLG_P" = "TRUE" ]; then
    docker build -t mmy100-kurima-nginx -f ./nginx/Dockerfile_prod .
    docker build -t mmy100-kurima-php -f ./php/Dockerfile_prod .
else
    docker build -t letterpack-nginx-dev -f ./nginx/Dockerfile .
    docker build -t letterpack-go-dev -f ./go/Dockerfile .
fi

exit 0
