#!/bin/bash

##
# Script to check NGINX logs
##

# Define log file paths
access_log="/var/log/nginx/access.log"
error_log="/var/log/nginx/error.log"

# Function to display last 20 lines of the access log
function check_access_log() {
    echo "Last 20 lines of the NGINX access log:"
    tail -n 20 $access_log
    echo ""
}

# Function to display last 20 lines of the error log
function check_error_log() {
    echo "Last 20 lines of the NGINX error log:"
    tail -n 20 $error_log
    echo ""
}

# Display both logs
check_access_log
check_error_log
