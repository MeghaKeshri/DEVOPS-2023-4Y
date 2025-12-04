#!/bin/bash

# Quick Start Script - Student Management Application
# This script helps you quickly build and run the application using Docker

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════╗
║   Student Management Application - Quick Start       ║
║   Docker Build, Push & Deploy                         ║
╚═══════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${GREEN}Choose an option:${NC}"
echo "1. Build Docker image locally"
echo "2. Build and push to Docker Hub"
echo "3. Run from local image"
echo "4. Pull and run from Docker Hub"
echo "5. Run with Docker Compose"
echo "6. View running containers"
echo "7. Stop and remove containers"
echo "8. Exit"
echo ""

read -p "Enter your choice (1-8): " choice

case $choice in
    1)
        echo -e "\n${YELLOW}🔨 Building Docker image locally...${NC}"
        docker build -t student-management:latest .
        echo -e "${GREEN}✅ Image built successfully!${NC}"
        echo -e "Run with: ${BLUE}docker run -p 8080:8080 student-management:latest${NC}"
        ;;
    2)
        echo -e "\n${YELLOW}🚀 Building and pushing to Docker Hub...${NC}"
        ./docker-build-push.sh
        ;;
    3)
        echo -e "\n${YELLOW}▶️  Running from local image...${NC}"
        docker run -d --name student-app -p 8080:8080 student-management:latest
        echo -e "${GREEN}✅ Application started!${NC}"
        echo -e "Access at: ${BLUE}http://localhost:8080${NC}"
        ;;
    4)
        echo -e "\n${YELLOW}📥 Pull and run from Docker Hub...${NC}"
        ./docker-run.sh
        ;;
    5)
        echo -e "\n${YELLOW}🐳 Starting with Docker Compose...${NC}"
        if [ ! -f .env ]; then
            cp .env.example .env
            echo -e "${YELLOW}⚠️  Created .env file from .env.example${NC}"
            echo -e "${YELLOW}   Please edit .env with your Docker Hub username${NC}"
            read -p "Press Enter to continue..."
        fi
        docker-compose up -d
        echo -e "${GREEN}✅ Application started with Docker Compose!${NC}"
        echo -e "Access at: ${BLUE}http://localhost:8080${NC}"
        echo -e "View logs: ${BLUE}docker-compose logs -f${NC}"
        ;;
    6)
        echo -e "\n${YELLOW}📋 Running containers:${NC}"
        docker ps
        ;;
    7)
        echo -e "\n${YELLOW}🛑 Stopping containers...${NC}"
        docker-compose down 2>/dev/null || true
        docker stop student-app 2>/dev/null || true
        docker rm student-app 2>/dev/null || true
        echo -e "${GREEN}✅ Containers stopped and removed${NC}"
        ;;
    8)
        echo -e "${GREEN}👋 Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo -e "${YELLOW}Invalid choice. Please run the script again.${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Done! 🎉${NC}"
