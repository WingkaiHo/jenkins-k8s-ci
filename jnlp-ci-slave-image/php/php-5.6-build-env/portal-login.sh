#!/bin/sh

curl  -s -c cookiec.txt -b cookiec.txt -X POST -H "Content-Type: application/json" "http://$PAAS_PORTAL_HOME/api/sys/login" --data "{\"username\" : \"$PAAS_PORTAL_USER\",\"password\" : \"$PAAS_PORTAL_PASSWORD\" }"
