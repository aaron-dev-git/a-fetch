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
	PKGMAN=/etc/debian_version
	if [ -f "$PKGMAN" ]; then
		pkg=$(dpkg --get-selections | wc --lines | sed 's/[[:space:]]//g')
		echo 'Packages: '$pkg'(dpkg)'
	fi

	#arch
	PKGMAN=/etc/arch-release
	if [ -f "$PKGMAN" ]; then
		pkg=$(pacman -Q | wc -l)
		echo 'Packages: '$pkg'(pacman)'
	fi

		#SuSE
	PKGMAN=/etc/SuSE-release
	if [ -f "PKGMAN" ]; then
		pkg=$(zypper se -s | wc -l)
		echo 'Packages: '$pkg'(zypper)'
	fi

			#gentoo
	PKGMAN=/etc/gentoo-release
	if [ -f "$PKGMAN" ]; then
		pkg=$(ls /var/db/pkg/* | wc -l)
		echo 'Packages: '$pkg'(emerge)'
	fi

#redhat
	PKGMAN=/etc/redhat-release
	if [ -f "$PKGMAN" ]; then
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
