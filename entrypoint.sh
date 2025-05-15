#!/bin/sh
set -e  # Exit on any error

# Default to master if DOCKSAL_VERSION is not set
export DOCKSAL_VERSION="${DOCKSAL_VERSION:-master}"

# Create installation directory
echo "Creating Docksal directory..."
sudo mkdir -p $GITHUB_WORKSPACE/docksal

# Download fin with verification
echo "Downloading fin version ${DOCKSAL_VERSION}..."
DOWNLOAD_URL="https://raw.githubusercontent.com/docksal/docksal/${DOCKSAL_VERSION}/bin/fin?r=${RANDOM}"
if ! sudo curl -fsSL "$DOWNLOAD_URL" -o $GITHUB_WORKSPACE/docksal/fin; then
    echo "Failed to download fin"
    exit 1
fi

# Make fin executable
echo "Making fin executable..."
sudo chmod +x $GITHUB_WORKSPACE/docksal/fin

# Add to PATH and set environment variable
echo "Configuring environment..."
echo "$GITHUB_WORKSPACE/docksal" >> $GITHUB_PATH
echo "fin=$GITHUB_WORKSPACE/docksal/fin" >> $GITHUB_ENV

# Verify installation
echo "Verifying installation..."
if [ -f "$GITHUB_WORKSPACE/docksal/fin" ]; then
    echo "Docksal fin installed successfully"
else
    echo "Installation verification failed"
    exit 1
fi