#!/bin/bash

# Docker Build and Push Script for Student Management Application
# This script builds the Docker image and pushes it to Docker Hub

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🐳 Docker Build and Push Script${NC}"
echo "=================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker and try again.${NC}"
    exit 1
fi

# Get Docker Hub username
read -p "Enter your Docker Hub username: " DOCKERHUB_USERNAME

if [ -z "$DOCKERHUB_USERNAME" ]; then
    echo -e "${RED}❌ Docker Hub username is required${NC}"
    exit 1
fi

IMAGE_NAME="${DOCKERHUB_USERNAME}/student-management"
VERSION=${1:-latest}

echo -e "\n${YELLOW}📦 Building Docker image...${NC}"
docker build -t ${IMAGE_NAME}:${VERSION} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Docker image built successfully!${NC}"
else
    echo -e "${RED}❌ Docker build failed!${NC}"
    exit 1
fi

# Tag as latest if version is specified
if [ "$VERSION" != "latest" ]; then
    echo -e "\n${YELLOW}🏷️  Tagging image as latest...${NC}"
    docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
fi

echo -e "\n${YELLOW}🔐 Logging in to Docker Hub...${NC}"
docker login

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Docker Hub login failed!${NC}"
    exit 1
fi

echo -e "\n${YELLOW}🚀 Pushing image to Docker Hub...${NC}"
docker push ${IMAGE_NAME}:${VERSION}

if [ "$VERSION" != "latest" ]; then
    docker push ${IMAGE_NAME}:latest
fi

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}✅ Successfully pushed to Docker Hub!${NC}"
    echo -e "\n${GREEN}📌 Image details:${NC}"
    echo -e "   Repository: ${IMAGE_NAME}"
    echo -e "   Tags: ${VERSION}"
    [ "$VERSION" != "latest" ] && echo -e "         latest"
    echo -e "\n${GREEN}🎯 To run the container:${NC}"
    echo -e "   docker run -p 8080:8080 ${IMAGE_NAME}:${VERSION}"
else
    echo -e "${RED}❌ Failed to push to Docker Hub!${NC}"
    exit 1
fi
