#!/bin/bash

# Function to install packages
install_packages() {
    # List of packages to install
    packages=("git" "python" "ansible" "docker")

    OS=""

    # Detect the operating system
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            OS="ubuntu"
        elif command -v yum &> /dev/null; then
            OS="redhat"
        elif command -v pacman &> /dev/null; then
            OS="arch"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="mac"
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
            OS="wsl"
        else
            echo "Unsupported Windows environment. Use WSL for Linux-based package management."
            return 1
        fi
    else
        echo "Unsupported operating system."
        return 1
    fi

    # Install the packages based on the detected OS
    case $OS in
        "ubuntu")
            echo "Detected Ubuntu. Installing packages using apt-get..."
            sudo apt-get update
            for package in "${packages[@]}"; do
                sudo apt-get install -y $package
            done
            ;;
        "redhat")
            echo "Detected Red Hat. Installing packages using yum..."
            sudo yum update
            for package in "${packages[@]}"; do
                sudo yum install -y $package
            done
            ;;
        "mac")
            echo "Detected macOS. Installing packages using brew..."
            for package in "${packages[@]}"; do
                brew install $package
            done
            ;;
        "wsl")
            echo "Detected WSL. Installing packages using apt-get..."
            sudo apt-get update
            for package in "${packages[@]}"; do
                sudo apt-get install -y $package
            done
            ;;
        *)
            echo "Unsupported operating system."
            return 1
            ;;
    esac
}

# Example usage:
install_packages
