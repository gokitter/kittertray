#!/bin/bash
MINKE_VERSION="1.12.9"
ERROR="Please specify a command e.g. ./minke.sh rake app:test"

DOCKER_SOCK="/var/run/docker.sock:/var/run/docker.sock"
NEW_UUID=$(base64 /dev/urandom | tr -d '/+' | head -c 32 | tr '[:upper:]' '[:lower:]')

GEMSET=$(<.ruby-gemset)
LEN=$(echo ${#GEMSET})

if [ $LEN -lt 1 ]; then
  GEMSET='minkegems'
fi

GEMSETFOLDER="/usr/local/rvm/gems/ruby-2.3.1@${GEMSET}"
RVM_COMMAND="source /usr/local/rvm/scripts/rvm && rvm gemset use ${GEMSET} --create"
DOCKER_IMAGE="nicholasjackson/minke:${MINKE_VERSION}"
COMMAND=""


if [ "$1" == '' ]; then
  echo $ERROR;
  exit 1;
fi

COMMAND=$*

# Test if interactive terminal and set the flag
[[ -t 1 ]] && IT="-it" || IT=""

if [[ $1 == \ -g* ]]; then
  echo "Generating new template"
  DIR=${PWD}
  DOCKER_RUN="docker run --rm -v ${DOCKER_SOCK} -v ${DIR}:${DIR} -v ${DIR}/_build/vendor/gems:${GEMSETFOLDER} -e DOCKER_NETWORK=minke_${NEW_UUID} -w ${DIR} ${DOCKER_IMAGE} /bin/bash -c '${RVM_COMMAND} && bundle install && minke ${COMMAND}'"
  eval "${DOCKER_RUN}"
fi

if [[ $1 != \ -g* ]]; then
  DIR=$(dirname `pwd`)
  DOCKER_RUN="docker run --rm ${IT} --net=minke_${NEW_UUID} -v ${DOCKER_SOCK} -v ${DIR}:${DIR} -v ${DIR}/_build/vendor/gems:${GEMSETFOLDER} -e DOCKER_NETWORK=minke_${NEW_UUID} -w ${DIR}/_build ${DOCKER_IMAGE} /bin/bash -c '${RVM_COMMAND} && ${COMMAND}'"

  echo "Running command: ${COMMAND}"

  eval "docker network create minke_${NEW_UUID}"
  eval "${DOCKER_RUN}"
  eval "docker network rm minke_${NEW_UUID}"
fi
