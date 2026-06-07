#!/bin/bash

# ==========================================
# Helper Function (কমান্ডের কাজ শেষে অপেক্ষা করার জন্য)
# ==========================================
pause_menu() {
    echo ""
    read -p "Press Enter to go back..."
}

# ==========================================
# 1. SETUP MENU (সেটআপ সম্পর্কিত কাজের ফোল্ডার)
# ==========================================
menu_setup() {
    while true; do
        clear
        echo "========================================="
        echo "             [ SETUP MENU ]              "
        echo "========================================="
        echo "1. Basic Termux Setup"
        echo "2. Install Platform Tools"
        echo "9. Back to Main Menu"
        echo "0. Exit Tool"
        echo "========================================="
        read -p "Enter your choice: " choice < /dev/tty

        case $choice in
            1)
                clear
                echo "[*] Running Basic Setup..."
                # --- ADD COMMANDS BELOW ---
                pkg update -y && pkg upgrade -y
                # --- ADD COMMANDS ABOVE ---
                echo "[✔] Done!"
                pause_menu
                ;;
            2)
                clear
                echo "[*] Installing Android Tools..."
                # --- ADD COMMANDS BELOW ---
                curl -s https://raw.githubusercontent.com/nohajc/termux-adb/master/install.sh | bash
                # --- ADD COMMANDS ABOVE ---
                echo "[✔] Done!"
                pause_menu
                ;;
            3)
                clear
                echo "[*] Termux Setup Storage..."
                # --- ADD COMMANDS BELOW ---
                termux-setup-storage
                # --- ADD COMMANDS ABOVE ---
                echo "[✔] Done!"
                pause_menu
                ;;
            9)
                break # এটি চাপলে আগের মেনুতে ফিরে যাবে
                ;;
            0)
                exit 0
                ;;
            *)
                echo "[!] Invalid Option!" && sleep 2 ;;
        esac
    done
}

# ==========================================
# 2. ADB MENU (ADB সম্পর্কিত কাজের ফোল্ডার)
# ==========================================
menu_adb() {
    while true; do
        clear
        echo "========================================="
        echo "              [ ADB MENU ]               "
        echo "========================================="
        echo "1. Check ADB Devices"
        echo "2. Reboot to Recovery"
        echo "3. Reboot to Bootloader"
        echo "9. Back to Main Menu"
        echo "0. Exit Tool"
        echo "========================================="
        read -p "Enter your choice: " choice

        case $choice in
            1)
                clear
                echo "[*] Checking connected ADB devices..."
                # --- ADD COMMANDS BELOW ---
                termux-adb devices
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            2)
                clear
                echo "[*] Rebooting to Recovery Mode..."
                # --- ADD COMMANDS BELOW ---
                termux-adb reboot recovery
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            3)
                clear
                echo "[*] Rebooting to Bootloader/Fastboot..."
                # --- ADD COMMANDS BELOW ---
                termux-adb reboot bootloader
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            9)
                break
                ;;
            0)
                exit 0
                ;;
            *)
                echo "[!] Invalid Option!" && sleep 2 ;;
        esac
    done
}

# ==========================================
# 3. FASTBOOT MENU (Fastboot সম্পর্কিত কাজের ফোল্ডার)
# ==========================================
menu_fastboot() {
    while true; do
        clear
        echo "========================================="
        echo "            [ FASTBOOT MENU ]            "
        echo "========================================="
        echo "1. Check Fastboot Devices"
        echo "2. Reboot to System"
        echo "3. Flash boot"
        echo "9. Back to Main Menu"
        echo "0. Exit Tool"
        echo "========================================="
        read -p "Enter your choice: " choice

        case $choice in
            1)
                clear
                echo "[*] Checking connected Fastboot devices..."
                # --- ADD COMMANDS BELOW ---
    
                # ৩ সেকেন্ডের জন্য কমান্ডটি রান করবে
                timeout 3s termux-fastboot devices
                
                # যদি ৩ সেকেন্ড পার হয়ে যায় এবং কমান্ড আটকে থাকে (Timeout Error 124)
                if [ $? -eq 124 ]; then
                    echo ""
                    echo "[!] No fastboot device detected or connection timed out!"
                fi
                
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            2)
                clear
                echo "[*] Rebooting device to System..."
                # --- ADD COMMANDS BELOW ---
                termux-fastboot reboot
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            3)
                clear
                echo "[*] Rebooting device to System..."
                # --- ADD COMMANDS BELOW ---
                termux-fastboot flash boot mboot.img
                # --- ADD COMMANDS ABOVE ---
                pause_menu
                ;;
            9)
                break
                ;;
            0)
                exit 0
                ;;
            *)
                echo "[!] Invalid Option!" && sleep 2 ;;
        esac
    done
}

# ==========================================
# MAIN MENU (মূল মেনু যেখান থেকে ক্যাটাগরিতে যাবে)
# ==========================================
while true; do
    clear
    echo "========================================="
    echo "         MY MASTER AUTO TOOL             "
    echo "========================================="
    echo "1. Setup Menu    (Installations & Updates)"
    echo "2. ADB Menu      (ADB Commands)"
    echo "3. Fastboot Menu (Fastboot Commands)"
    echo "0. Exit Tool"
    echo "========================================="
    read -p "Select Category: " main_choice

    case $main_choice in
        1)
            menu_setup
            ;;
        2)
            menu_adb
            ;;
        3)
            menu_fastboot
            ;;
        0)
            clear
            echo "Exiting Master Tool..."
            exit 0
            ;;
        *)
            echo "[!] Invalid Option!" && sleep 2
            ;;
    esac
done
