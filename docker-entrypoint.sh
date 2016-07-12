#!/bin/sh

terminate () {
  /opt/backendless/ctlscript.sh stop
  exit 0
}

trap terminate SIGINT SIGTERM

/opt/backendless/ctlscript.sh start

sleep inf