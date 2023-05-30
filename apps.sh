#!/bin/bash

# Array to store program names
declare -a programs=("gobuster" "shellter" "fluxion" "airgeddon" "beef" "burpsuite" "dhcpig" "chntpw" "whatweb" "macchanger" "netcat" "bettercap" "recon-ng" "netdiscover" "ffuf" "wifiphisher" "sqlmap" "metasploit" "wireshark" "shellter" "evillimiter" "netTool" "httrack" "speedtest" "speedtest-cli" "mariadb" "mysql" "macchanger" "mbpfan" "hollywood" "cowsay")

# Function to install programs using Pacman or Yay
install_programs() {
  for program in "${programs[@]}"; do
    # Check if the program is available in Pacman repositories
    if pacman -Si "$program" &> /dev/null; then
      echo "Installing $program using Pacman..."
      sudo pacman -S --noconfirm "$program"
    else
      echo "Program $program not found in Pacman repositories."
      # You can add custom logic here to handle installation from other sources or skipping installation
    fi
  done
}

# Remove duplicate program names from the array
programs=($(echo "${programs[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# Install programs
install_programs
