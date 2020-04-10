#!/usr/bin/env bash

DOCKER_HUB_REPO=macunha1/ansible
DOCKER_HUB_NAMESPACE=${DOCKER_HUB_NAMESPACE:-${DOCKER_HUB_LOGIN}}
DOCKER_HUB_BUILD_API="https://hub.docker.com/api/build/v1/${DOCKER_HUB_NAMESPACE}"

DOCKER_HUB_TOKEN=$(
	curl -X POST -L -H "Content-Type: application/json" \
		-d '{"username": "'${DOCKER_HUB_LOGIN}'",
             "password": "'${DOCKER_HUB_PASS}'"}' \
		https://hub.docker.com/v2/users/login/ | jq -r .token
)

DOCKER_HUB_BUILD_OBJECT=$(
	curl -X GET -L -H "Content-Type: application/json" \
		-H "Authorization: JWT ${DOCKER_HUB_TOKEN}" \
		"${DOCKER_HUB_BUILD_API}/source/?image=${DOCKER_HUB_REPO}" |
		jq -r '.objects[0]'
)

DOCKER_HUB_BUILD_UUID=$(echo ${DOCKER_HUB_BUILD_OBJECT} | jq -r '.uuid')
DOCKER_HUB_BUILD_PAYLOAD=$(echo ${DOCKER_HUB_BUILD_OBJECT} |
	jq 'del(.uuid, .image, .state, .resource_uri, .build_settings)')

for DOCKERFILE_PATH in $(find . -type f -name Dockerfile); do
	DOCKER_IMAGE_TAG=$(
		echo ${DOCKERFILE_PATH} |
			awk -F'/' '{ printf "%s-%s-%s", $4, $3, $5 }'
	)

	DOCKER_HUB_BUILD_PAYLOAD=$(
		echo ${DOCKER_HUB_BUILD_PAYLOAD} |
			jq -c '.build_settings += [{
           "source_type": "Branch",
           "tag": "'${DOCKER_IMAGE_TAG}'",
           "dockerfile": "'${DOCKERFILE_PATH}'",
           "source_name": "master",
           "build_context": "/",
           "autobuild": true,
           "nocache": false,
           "uuid": ""
         }]'
	)
done

curl -X PATCH -L -H "Content-Type: application/json" \
	-H "Authorization: JWT ${DOCKER_HUB_TOKEN}" \
	-d "${DOCKER_HUB_BUILD_PAYLOAD}" \
	"${DOCKER_HUB_BUILD_API}/source/${DOCKER_HUB_BUILD_UUID}/"
