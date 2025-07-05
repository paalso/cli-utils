#!/bin/bash
# Stop the only running container or ask if more than one container is running

CONTAINER_ID=$(docker ps -q)
CONTAINER_COUNT=$(echo "$CONTAINER_ID" | wc -l)

if [ "$CONTAINER_COUNT" -eq 1 ]; then
    docker stop "$CONTAINER_ID"
    echo "Container $CONTAINER_ID has been stopped."
elif [ "$CONTAINER_COUNT" -gt 1 ]; then
    echo "Multiple containers are running. Please stop them manually."
else
    echo "No running containers."
fi
