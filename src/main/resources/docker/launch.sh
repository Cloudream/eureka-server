#!/bin/bash
REGISTRY_URL=192.168.199.135:2375
WORK_DIR=/root/work_build
PROJECT_NAME=eureka-server
PROJECT_VERSION=0.0.1-SNAPSHOT
if [ ! -e ${WORK_DIR}/${PROJECT_NAME} ] && [ ! -d ${WORK_DIR}/${PROJECT_NAME} ]; then
mkdir -p ${WORK_DIR}/${PROJECT_NAME}
echo "Create Dir: ${WORK_DIR}/${PROJECT_NAME}"
fi
if [ -e ${WORK_DIR}/${PROJECT_NAME}/Dockerfile ]; then
rm -rf ${WORK_DIR}/${PROJECT_NAME}/Dockerfile
echo "Remove File: ${WORK_DIR}/${PROJECT_NAME}/Dockerfile"
fi
cp /root/.jenkins/workspace/eureka-server/Dockerfile ${WORK_DIR}/${PROJECT_NAME}/
cp /root/.jenkins/workspace/eureka-server/target/*.jar ${WORK_DIR}/${PROJECT_NAME}/
cd ${WORK_DIR}/${PROJECT_NAME}/
docker build -t ${REGISTRY_URL}/eshop-detail/${PROJECT_NAME}:${PROJECT_VERSION} .
docker push ${REGISTRY_URL}/eshop-detail/${PROJECT_NAME}:${PROJECT_VERSION}
if docker ps -a | grep ${PROJECT_NAME}; then
docker rm -f ${PROJECT_NAME}
echo "Remove Docker Container: ${PROJECT_NAME}"
fi
docker run -d -p 8761:8761 --name ${PROJECT_NAME} ${REGISTRY_URL}/eshop-detail/${PROJECT_NAME}:${PROJECT_VERSION}