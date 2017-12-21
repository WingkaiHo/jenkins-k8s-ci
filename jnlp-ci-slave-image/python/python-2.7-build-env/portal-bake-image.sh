#!/bin/sh -x

GIT_COMMIT_ID=$(git rev-parse --short HEAD)

RESULT_STR=$(curl -s -b cookiec.txt -c cookiec.txt -X POST  "http://$PAAS_PORTAL_HOME/api/cd/version" --form imageFile=@ROOT.tar --form imageName=$DOCKER_IMAGE_NAME --form versionName=$DOCKER_IMAGE_VERSION-$GIT_COMMIT_ID --form runtimeEnvId=$RUNTIME_ENV_ID --form key=$DOCKER_IMAGE_BUILDING_KEY)

CODE=$(echo $RESULT_STR | awk -F "[{,}:]" '{print $3}')

if [ "$CODE" = "0" ]; then
	echo "SUCCESS"
	echo $RESULT_STR
	exit 0
fi

echo $RESULT_STR
exit 1

