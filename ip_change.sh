#!/bin/bash
echo -e "\033[1;31m

'  ████████╗███████╗ ██████╗██╗  ██╗     ██████╗██╗   ██╗ █████╗ ███╗   ██╗██╗
'  ╚══██╔══╝██╔════╝██╔════╝██║  ██║    ██╔════╝╚██╗ ██╔╝██╔══██╗████╗  ██║██║
'     ██║   █████╗  ██║     ███████║    ██║  ███╗╚████╔╝ ███████║██╔██╗ ██║██║
'     ██║   ██╔══╝  ██║     ██╔══██║    ██║   ██║ ╚██╔╝  ██╔══██║██║╚██╗██║██║
'     ██║   ███████╗╚██████╗██║  ██║    ╚██████╔╝  ██║   ██║  ██║██║ ╚████║██║
'     ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝     ╚═════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝
'                                                                             
\033[0m"

# Ensure the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Define the menu
function show_menu() {
    echo "============================="
    echo " AnonSurf Menu "
    echo "============================="
    echo "1) Start AnonSurf"
    echo "2) Check AnonSurf Status"
    echo "3) Change IP"
    echo "4) Check IP on dnsleaktest.com"
    echo "5) Automatically Change IP every 5 seconds"
    echo "6) Exit"
    echo "============================="
}

# Run AnonSurf Menu
function run_menu() {
    while true; do
        show_menu
        read -rp "Choose an option: " option
        
        case $option in
            1)
                echo "Starting AnonSurf..."
                anonsurf start
                ;;
            2)
                echo "Checking AnonSurf status..."
                anonsurf status
                ;;
            3)
                echo "Changing IP..."
                anonsurf change
                ;;
            4)
                echo "Checking IP on dnsleaktest.com..."
                curl https://www.dnsleaktest.com/
                ;;
            5)
                echo "Automatically changing IP every 5 seconds..."
                watch -n 5 "anonsurf change"
                ;;
            6)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid option! Please try again."
                ;;
        esac
    done
}

# Start the menu
run_menu
