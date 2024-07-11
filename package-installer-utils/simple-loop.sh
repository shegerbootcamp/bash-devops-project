#!/bin/bash

# List of packages to install
packages=("git" "python" "ansible" "docker")

# Install each package in the list
for package in "${packages[@]}"; do
    echo "Installing $package..."
    sudo apt-get install -y $package
done
