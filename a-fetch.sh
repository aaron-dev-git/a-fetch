#!/bin/bash

# OS Name
	system=$(lsb_release -d | awk '{print $2,$3,$4,$5}')
	echo 'OS: '$system

# Kernel Version
	kernel=$(uname -r)
	echo 'Kernel: '$kernel

#uptime
	uptime=$(uptime -p | awk '{print $2,$3,$4,$5}')
	echo 'Uptime: '$uptime

#packages

#debian
	if [ PKGMAN=/etc/debian_version | -f "$PKGMAN" ]; then
		pkg=$(dpkg --get-selections | wc --lines | sed 's/[[:space:]]//g')
		echo 'Packages: '$pkg'(dpkg)'
#arch
	elif [ PKGMAN=/etc/arch-release | -f "$PKGMAN" ]; then
		pkg=$(pacman -Q | wc -l)
		echo 'Packages: '$pkg'(pacman)'
#SuSE
	elif [ PKGMAN=/etc/SuSE-release | -f "PKGMAN" ]; then
		pkg=$(zypper se -s | wc -l)
		echo 'Packages: '$pkg'(zypper)'
#gentoo
	elif [ PKGMAN=/etc/gentoo-release | -f "$PKGMAN" ]; then
		pkg=$(ls /var/db/pkg/* | wc -l)
		echo 'Packages: '$pkg'(emerge)'
#redhat
	elif [ PKGMAN=/etc/redhat-release | -f "$PKGMAN" ]; then
		pkg=$(yum list installed  | wc -l)
		echo 'Packages: '$pkg'(yum)'
	fi

#shell
	echo 'Shell: '$SHELL

#resolution
	res=$(xdpyinfo | awk '/dimensions/{print $2}')
	echo 'Resolution:'$res

#CPU
	cpu=$(grep -m 1 'model name' /proc/cpuinfo | awk '{print $4,$5,$6,$7,$8,$9}')
	core=$(grep -c 'model name' /proc/cpuinfo)
	echo "CPU: "$cpu "("$core "threads)"

#Memory
	usedmem=$(free -m | awk '/^Mem:/ {print $3}' | sed 's/Gi/GB/g')
	totalmem=$(free -m | awk '/^Mem:/ {print $2}' | sed 's/Gi/GB/g')
	echo "Memory: "$usedmem"MB / "$totalmem"MB"
exit 0
x
