#!/usr/bin/env bash

#Author: stttt2003pk
#Description: install the call of duty 4 serverfiles

clear

echo "================================="
echo "call of duty 4 server"
echo "stttt2003pk linux game server cod4"
echo "by stttt2003pk"
echo "stttt2003pk@gmail.com"
echo "================================="

echo ""
echo "Server Directory"
echo "================================="
sleep 1
echo ""

pwd

echo ""

if [ -z "${autoinstall}" ]; then
    if [[ "${getopt}" == "install" ]] || [[ "${getopt}" == "i" ]]; then
        while true; do
            read -e -i "y" -p "Install the cod 4 server in your linux:[y|n]" yn
            case ${yn} in
                [Yy]*)
                    break;;
                [Nn]*)
                    exit 0;;
                *)
                    echo "Please answer yes or no.";;
            esac
        done
    fi
fi

#build the dir if the dir does not exited
if [ ! -d ${filesdir} ] || [ ! -d ${tmpdir} ]; then
	mkdir -pv "${filesdir}";
	mkdir -pv "${tmpdir}"
fi

sleep 1

#build the log if the log did not exited
if [ -d ${scriptlogdir} ]; then
	fn_print_dots "Checking for log files"
	sleep 0.3
	fn_print_info_nl "Checking for log files: log files exists"
else
	echo "Creating log dir"
	echo "================"
	sleep 1
	mkdir -pv "${rootdir}/log"
	mkdir -pv "${scriptlogdir}"
	touch "${scriptlog}"
fi

if [ ! -h "${rootdir}/log/server" ]; then
	ln -nfsv "${gamelogdir}" "${rootdir}/log/server"
fi

if [ -d "${rootdir}/Steam/logs" ]; then
	if [  ! -h "${rootdir}/log/steamcmd" ]; then
		ln -nfsv "${rootdir}/Steam/logs" "${rootdir}/log/steamcmd"
	fi
fi

fn_script_log_info "Logs installed"

check_deps.sh

echo ""
echo "Installing serverfiles"
echo "================================="
sleep 1

install_server_files.sh




































