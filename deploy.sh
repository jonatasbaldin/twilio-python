#!/bin/bash

export API_DEFINITIONS_SHA=$(git log --oneline | grep Regenerated | head -n1 | cut -d ' ' -f 5)
# make docker-build
# make docker-push

docker build -t jonatasbaldin/twilio-python .
docker tag jonatasbaldin/twilio-python jonatasbaldin/twilio-python:$TRAVIS_TAG
docker tag jonatasbaldin/twilio-python jonatasbaldin/twilio-python:apidefs-$API_DEFINITIONS_SHA

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push jonatasbaldin/twilio-python:$TRAVIS_TAG
docker push jonatasbaldin/twilio-python:apidefs-$API_DEFINITIONS_SHA
