#!/bin/bash

# Docker Run Script for Student Management Application

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🐳 Student Management Application - Docker Runner${NC}"
echo "===================================================="

# Get Docker Hub username
read -p "Enter your Docker Hub username (or press Enter to use local image): " DOCKERHUB_USERNAME

if [ -z "$DOCKERHUB_USERNAME" ]; then
    IMAGE_NAME="student-management"
else
    IMAGE_NAME="${DOCKERHUB_USERNAME}/student-management"
fi

CONTAINER_NAME="student-management-app"
PORT=${1:-8080}

# Stop and remove existing container if it exists
if [ "$(docker ps -a -q -f name=${CONTAINER_NAME})" ]; then
    echo -e "${YELLOW}🛑 Stopping existing container...${NC}"
    docker stop ${CONTAINER_NAME} 2>/dev/null || true
    docker rm ${CONTAINER_NAME} 2>/dev/null || true
fi

echo -e "\n${YELLOW}🚀 Starting container...${NC}"
docker run -d \
    --name ${CONTAINER_NAME} \
    -p ${PORT}:8080 \
    --restart unless-stopped \
    ${IMAGE_NAME}:latest

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✅ Container started successfully!${NC}"
    echo -e "\n${GREEN}📌 Application details:${NC}"
    echo -e "   Container name: ${CONTAINER_NAME}"
    echo -e "   Port: ${PORT}"
    echo -e "   URL: http://localhost:${PORT}"
    echo -e "\n${GREEN}📝 Useful commands:${NC}"
    echo -e "   View logs: docker logs -f ${CONTAINER_NAME}"
    echo -e "   Stop: docker stop ${CONTAINER_NAME}"
    echo -e "   Restart: docker restart ${CONTAINER_NAME}"
    echo -e "   Remove: docker rm -f ${CONTAINER_NAME}"
else
    echo -e "${RED}❌ Failed to start container!${NC}"
    exit 1
fi
