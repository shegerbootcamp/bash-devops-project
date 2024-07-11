#!/bin/bash

# Check if git is installed
if command -v git &> /dev/null; then
    echo "git is already installed."
else
    echo "git is not installed. Installing git..."
    sudo apt-get install -y git
fi
