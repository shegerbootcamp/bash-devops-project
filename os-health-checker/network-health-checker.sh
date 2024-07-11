#!/bin/bash

##
# BASH menu script for network checks:
#   - Check IP address
#   - Check network interfaces
#   - Check open ports
#   - Check routing table
#   - Perform nslookup
##

server_name=$(hostname)

function ip_check() {
    echo ""
    echo "IP address on ${server_name} is: "
    ip addr show
    echo ""
}

function interface_check() {
    echo ""
    echo "Network interfaces on ${server_name} are: "
    ip link show
    echo ""
}

function open_ports_check() {
    echo ""
    echo "Open ports on ${server_name} are: "
    sudo netstat -tuln
    echo ""
}

function routing_table_check() {
    echo ""
    echo "Routing table on ${server_name} is: "
    ip route show
    echo ""
}

function nslookup_check() {
    echo ""
    echo -n "Enter the domain to perform nslookup: "
    read domain
    echo ""
    nslookup "$domain"
    echo ""
}

function all_checks() {
    ip_check
    interface_check
    open_ports_check
    routing_table_check
    nslookup_check
}

##
# Color Variables
##
green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

##
# Color Functions
##
ColorGreen() {
    printf "${green}$1${clear}"
}
ColorBlue() {
    printf "${blue}$1${clear}"
}

menu() {
    echo -ne "
Network Menu
$(ColorGreen '1)') Check IP address
$(ColorGreen '2)') Check network interfaces
$(ColorGreen '3)') Check open ports
$(ColorGreen '4)') Check routing table
$(ColorGreen '5)') Perform nslookup
$(ColorGreen '6)') Check All
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
    read -r a
    case $a in
        1) ip_check ; menu ;;
        2) interface_check ; menu ;;
        3) open_ports_check ; menu ;;
        4) routing_table_check ; menu ;;
        5) nslookup_check ; menu ;;
        6) all_checks ; menu ;;
        0) exit 0 ;;
        *) printf "${red}Wrong option.${clear}\n"; menu ;;
    esac
}

# Start the menu
menu
