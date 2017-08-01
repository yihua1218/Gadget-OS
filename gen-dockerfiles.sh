#!/bin/bash -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BOARDS="chippro chippro4gb"
COMMONFILE="$(ls ${SCRIPT_DIR}/common.Dockerfile)" # error out early if common.Dockerfile isn't here

HASH=$(git rev-parse --short=8 HEAD)
TIMESTAMP=$(date --iso-8601 -d @$(git show -s --format=%ct))
BRANCH=${CI_BUILD_REF_SLUG}

echo "${BRANCH}:${TIMESTAMP}-${HASH}" > .branch

# generating dockerfiles
echo "# generating dockerfiles"

for BOARD in ${BOARDS}; do
	
	cat ${COMMONFILE} > ${SCRIPT_DIR}/${BOARD}.Dockerfile
	# build board specific dockerfile, download it's kernel source
	echo "RUN cd /opt/gadget-os-proto && no_docker=true make ${BOARD}_defconfig && no_docker=true make linux-source" >> ${SCRIPT_DIR}/${BOARD}.Dockerfile
	
	# tag and upload board specific docker image
	docker build -t nextthingco/gadget-build-${BOARD}-${BRANCH}:${TIMESTAMP}-${HASH} -f ${SCRIPT_DIR}/${BOARD}.Dockerfile ${SCRIPT_DIR}
	docker tag nextthingco/gadget-build-${BOARD}-${BRANCH}:${TIMESTAMP}-${HASH}\
	 nextthingco/gadget-build-${BOARD}-${BRANCH}:latest

	docker push nextthingco/gadget-build-${BOARD}-${BRANCH}:${TIMESTAMP}-${HASH}
	docker push nextthingco/gadget-build-${BOARD}-${BRANCH}:latest
	
	rm ${SCRIPT_DIR}/${BOARD}.Dockerfile
	
done
