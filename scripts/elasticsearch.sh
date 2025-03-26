#!/bin/bash

# Set your private registry
PRIVATE_REGISTRY="746108190720.dkr.ecr.us-east-1.amazonaws.com"
IMAGE_NAME="elasticsearch"
VERSION="8.17.3"
SOURCE_IMAGE="docker.elastic.co/elasticsearch/elasticsearch:$VERSION"

# Ensure Docker CLI experimental features are enabled
export DOCKER_CLI_EXPERIMENTAL=enabled

# Function to pull, tag, and push an image for a specific architecture
function process_arch() {
    local ARCH=$1
    local TAG="$PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION-$ARCH"

    echo "Pulling $SOURCE_IMAGE for $ARCH..."
    docker pull --platform=linux/$ARCH $SOURCE_IMAGE

    echo "Tagging image as $TAG..."
    docker tag $SOURCE_IMAGE $TAG

    echo "Pushing $TAG to private registry..."
    docker push $TAG
}

# Process both architectures
process_arch amd64
process_arch arm64

# Create a multi-arch manifest
MANIFEST_TAG="$PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION"
echo "Creating multi-arch manifest for $MANIFEST_TAG..."
docker manifest create $MANIFEST_TAG \
    $PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION-amd64 \
    $PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION-arm64

# Annotate architectures
docker manifest annotate $MANIFEST_TAG $PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION-amd64 --arch amd64
docker manifest annotate $MANIFEST_TAG $PRIVATE_REGISTRY/$IMAGE_NAME:$VERSION-arm64 --arch arm64

# Push the multi-arch manifest
echo "Pushing multi-arch manifest to $PRIVATE_REGISTRY..."
docker manifest push $MANIFEST_TAG

echo "Multi-arch image pushed successfully: $MANIFEST_TAG"