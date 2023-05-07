#!/bin/bash

PWD=`pwd`
SCRIPT_DIR=$(cd $(dirname $0) && pwd)
PROJECT_ROOT=$SCRIPT_DIR/..

BOT_TARGET=https://starter-angular.moaiapps.net

if [ "$1" != "" ]; then
  BOT_TARGET="$1"
fi

echo BOT_TARGET=$BOT_TARGET

on_error() {
  echo "error $@"
  exit 1
}

cd $PROJECT_ROOT
docker build -t moaiapps/stress-testing:1.0 . || on_error docker build

SKIP=1
for i in $(cat $SCRIPT_DIR/bot-list.csv); do
  SKIP=$(($SKIP-1))
  if [ $SKIP -ge 0 ]; then continue; fi
  LOGIN_ID=$(echo $i | cut -d ',' -f 1 | sed "s/'/\\\'/g")
  PASSWORD=$(echo $i | cut -d ',' -f 2 | sed "s/'/\\\'/g")
  OPERATION=$(echo $i | cut -d ',' -f 3)
  ENV="-e BOT_TARGET=$BOT_TARGET -e BOT_LOGIN_ID='$LOGIN_ID' -e BOT_PASSWORD='$PASSWORD' -e BOT_OPERATION=$OPERATION"
  docker run -itd $ENV --rm moaiapps/stress-testing:1.0 || on_error docker run
done
