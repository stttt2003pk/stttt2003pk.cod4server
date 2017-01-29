#!/usr/bin/env bash

#Author: stttt2003pk
#Description: stop the cod4 server

status=$(tmux list-sessions 2>&1 | awk '{print $1}' | grep -Ec "^${servicename}:")

if [ "${status}" == "0" ]; then
    fn_print_info_nl "${servername} is not running"
    exit 0
else
    fn_print_dots "${servername}"
	echo ""
	echo "Command"
	echo "================================="
	echo "stopping the ${servername}"

	#kill the tmux session
	tmux kill-session -t "${servicename}" > /dev/null 2>&1
	status=$(tmux list-sessions 2>&1 | awk '{print $1}' | grep -Ec "^${servicename}:")
	if [ "${status}" == "0" ]; then
	    fn_print_ok_nl "${servername} stopped"
	    fn_script_log_pass "Stopped ${servername}"
	else
	    fn_print_fail_nl "Unable to stop${servername}"
	    fn_script_log_fatal "Unable to stop${servername}"
	fi
fi