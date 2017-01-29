#!/usr/bin/env bash

# Author: stttt2003pk
# Description: Displays server information.

fn_details_os(){
	#
	# Distro Details
	# =====================================
	# Distro:    Ubuntu 14.04.4 LTS
	# Arch:      x86_64
	# Kernel:    3.13.0-79-generic
	# Hostname:  hostname
	# tmux:      tmux 1.8
	# GLIBC:     2.19

	echo -e ""
	echo -e "${lightyellow}Distro Details${default}"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	{
		echo -e "${blue}Distro:\t${default}${distroname}"
		echo -e "${blue}Arch:\t${default}${arch}"
		echo -e "${blue}Kernel:\t${default}${kernel}"
		echo -e "${blue}Hostname:\t${default}$HOSTNAME"
		echo -e "${blue}tmux:\t${default}${tmuxv}"
		echo -e "${blue}GLIBC:\t${default}${glibcversion}"
	} | column -s $'\t' -t
}

fn_details_performance(){
	#
	# Performance
	# =====================================
	# Uptime:    55d, 3h, 38m
	# Avg Load:  1.00, 1.01, 0.78
	#
	# Mem:       total   used   free  cached
	# Physical:  741M    656M   85M   256M
	# Swap:      0B      0B     0B

	echo -e ""
	echo -e "${lightyellow}Performance${default}"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	{
		echo -e "${blue}Uptime:\t${default}${days}d, ${hours}h, ${minutes}m"
		echo -e "${blue}Avg Load:\t${default}${load}"
	} | column -s $'\t' -t
	echo -e ""
	{
		echo -e "${blue}Mem:\t${blue}total\t used\t free\t cached${default}"
		echo -e "${blue}Physical:\t${default}${physmemtotal}\t${physmemused}\t${physmemfree}\t${physmemcached}${default}"
		echo -e "${blue}Swap:\t${default}${swaptotal}\t${swapused}\t${swapfree}${default}"
	} | column -s $'\t' -t
}

fn_details_disk(){
	#
	# Storage
	# =====================================
	# Filesystem:   /dev/disk/by-uuid/320c8edd-a2ce-4a23-8c9d-e00a7af2d6ff
	# Total:        15G
	# Used:         8.4G
	# Available:    5.7G
	# LGSM Total:	1G
	# Serverfiles:  961M
	# Backups:  	2G

	echo -e ""
	echo -e "${lightyellow}Storage${default}"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	{
		echo -e "${blue}Filesystem:\t${default}${filesystem}"
		echo -e "${blue}Total:\t${default}${totalspace}"
		echo -e "${blue}Used:\t${default}${usedspace}"
		echo -e "${blue}Available:\t${default}${availspace}"
		echo -e "${blue}LGSM Total:\t${default}${rootdirdu}"
		echo -e "${blue}Serverfiles:\t${default}${filesdirdu}"
		if [ -d "${backupdir}" ]; then
			echo -e "${blue}Backups:\t${default}${backupdirdu}"
		fi
	} | column -s $'\t' -t
}

fn_details_gameserver(){
    echo -e ""
	echo -e "${lightgreen}${gamename} Server Details${default}"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	{
	    #servier name
	    if [ -n "${servername}" ]; then
			echo -e "${blue}Server name:\t${default}${servername}"
		fi
		# Server ip
		echo -e "${blue}Server IP:\t${default}${ip}:${port}"

		if [ -n "${maxplayers}" ]; then
			echo -e "${blue}Maxplayers:\t${default}${maxplayers}"
		fi

		status=$(tmux list-sessions 2>&1 | awk '{print $1}' | grep -Ec "^${servicename}:")
        if [ "${status}" == "0" ]; then
            echo -e "${blue}Status:\t${red}OFFLINE${default}"
        else
            echo -e "${blue}Status:\t${green}ONLINE${default}"
        fi

	} | column -s $'\t' -t
    echo -e ""
}

fn_details_cod4(){
	echo -e "netstat -atunp"
	echo -e ""
	{
		echo -e "DESCRIPTION\tDIRECTION\tPORT\tPROTOCOL"
		echo -e "> Game\tINBOUND\t${port}\tudp"
	} | column -s $'\t' -t
}

fn_details_commandlineparms(){
	#
	# Command-line Parameters
	# =====================================
	# ./run_server_x86.sh +set net_strict 1

	echo -e ""
	echo -e "${lightgreen}Command-line Parameters${default}"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
	echo -e "${executable} ${parms}"
}

fn_details_script(){
#
	# qlserver Script Details
	# =====================================
	# Service name:        ql-server
	# qlserver version:    150316
	# User:                lgsm
	# Email alert:  off
	# Update on start:     off
	# Location:            /home/lgsm/qlserver
	# Config file:         /home/lgsm/qlserver/serverfiles/baseq3/ql-server.cfg
    echo -e "${lightgreen}${selfname} Script Details${default}"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
    {
        # Service name
		echo -e "${blue}Service name:\t${default}${servicename}"
		# User
		echo -e "${blue}User:\t${default}$(whoami)"

		echo -e "${blue}Location:\t${default}${rootdir}"

		if [ -n "${servercfgfullpath}" ]; then
			if [ -f "${servercfgfullpath}" ]; then
				echo -e "${blue}Config file:\t${default}${servercfgfullpath}"
			elif [ -d "${servercfgfullpath}" ]; then
				echo -e "${blue}Config dir:\t${default}${servercfgfullpath}"
			else
				echo -e "${blue}Config file:\t${default}${red}${servercfgfullpath}${default} (${red}FILE MISSING${default})"
			fi
		fi

    } | column -s $'\t' -t
}


info_distro.sh
fn_details_os
fn_details_performance
fn_details_disk
fn_details_cod4
fn_details_commandlineparms
fn_details_script
fn_details_gameserver