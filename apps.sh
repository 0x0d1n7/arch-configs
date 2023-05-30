#!/bin/bash

# Array to store program names
declare -a programs=(
  "gobuster" 
  "shellter" 
  "fluxion" 
  "airgeddon" 
  "beef" 
  "burpsuite" 
  "dhcpig" 
  "chntpw" 
  "whatweb" 
  "macchanger" 
  "netcat" 
  "bettercap" 
  "recon-ng" 
  "netdiscover" 
  "ffuf" 
  "wifiphisher" 
  "sqlmap" 
  "metasploit" 
  "wireshark" 
  "shellter" 
  "evillimiter" 
  "netTool" 
  "httrack" 
  "speedtest" 
  "speedtest-cli" 
  "mariadb" 
  "mysql" 
  "macchanger" 
  "mbpfan" 
  "hollywood" 
  "cowsay" 
  "nmap" 
  "openvas" 
  "nikto" 
  "dirb" 
  "enum4linux" 
  "john" 
  "hydra" 
  "hashcat" 
  "sqlninja" 
  "yersinia" 
  "arp-scan" 
  "dnsenum" 
  "fimap" 
  "wpscan" 
  "mitmproxy" 
  "snort" 
  "lynis"
)

# Array to store programs that are not available
declare -a not_available=()

# Function to enable the BlackArch repository
enable_blackarch_repo() {
  if ! grep -q "[blackarch]" /etc/pacman.conf; then
    echo -e "\n[blackarch]\nServer = https://blackarch.org/strap.sh\nSigLevel = Optional TrustAll" | sudo tee -a /etc/pacman.conf > /dev/null
    sudo pacman -Syy
    curl -O https://blackarch.org/strap.sh
    chmod +x strap.sh
    sudo ./strap.sh
    rm strap.sh
  fi
}

# Function to install programs using Pacman or Yay
install_programs() {
  for program in "${programs[@]}"; do
    # Check if the program is available in Pacman repositories
    if pacman -Si "$program" &> /dev/null; then
      echo "Installing $program using Pacman..."
      sudo pacman -S --noconfirm "$program"
    else
      echo "Program $program not found in Pacman repositories. Skipping installation."
      not_available+=("$program")
    fi
  done
}

# Enable BlackArch repository
enable_blackarch_repo

# Remove duplicate program names from the array
programs=($(echo "${programs[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# Install programs
install_programs

# Save the list of programs that are not available to a text file
if [ ${#not_available[@]} -gt 0 ]; then
  printf '%s\n' "${not_available[@]}" > not_available.txt
  echo "The following programs were not found in the Pacman repositories and were saved to not_available.txt:"
  cat not_available.txt
fi
