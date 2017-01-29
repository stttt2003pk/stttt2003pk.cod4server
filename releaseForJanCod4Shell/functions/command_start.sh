#!/usr/bin/env bash

#Author: stttt2003pk
#Description: start the cod4 server into tmux
#

#check if the server is running
#parms like "+set sv_punkbuster 0 +set fs_basepath ${filesdir} +set dedicated 1 +set net_ip ${ip} +set net_port ${port} +set sv_maxclients ${maxclients} +exec ${servercfg} +map ${defaultmap}"
#cd {filesdir} && {executable} +set sv_punkbuster 0 +set fs_basepath ${filesdir} +set dedicated 1 +set net_ip ${ip} +set net_port ${port} +set sv_maxclients ${maxclients} +exec ${servercfg} +map ${defaultmap}

parms="+set sv_punkbuster 0 +set fs_basepath ${filesdir} +set dedicated 1 +set net_ip ${ip} +set net_port ${port} +set sv_maxclients ${maxclients} +exec ${servercfg} +map ${defaultmap}"
lockselfname=".${servicename}.lock"

scriptlogdate="${scriptlogdir}/${servicename}-script-$(date '+%Y-%m-%d-%H:%M:%S').log"
consolelogdate="${consolelogdir}/${servicename}-console-$(date '+%Y-%m-%d-%H:%M:%S').log"

fn_start_tmux(){
    status=$(tmux list-sessions 2>&1 | awk '{print $1}' | grep -Ec "^${servicename}:")
    if [ "${status}" != "0" ]; then
        fn_print_info_nl "${servername} is already running"
        fn_script_log_error "${servername} is already running"
        core_exit.sh
    fi

    if [ "${status}" == "0" ]; then
        fn_script_log_info "Rotating log files"
        mv "${scriptlog}" "${scriptlogdate}"
        mv "${consolelog}" "${consolelogdate}"
    fi

    date > "${rootdir}/${lockselfname}"
    cd "${executabledir}"

    tmux new-session -d -s "${servicename}" "${executable} ${parms}" 2> "${scriptlogdir}/.${servicename}-tmux-error.tmp"

    status=$(tmux list-sessions 2>&1 | awk '{print $1}' | grep -Ec "^${servicename}:")

    if [ "${status}" == "0" ]; then
        fn_print_fail_nl "Unable to start ${servername}"
        fn_script_log_fatal "Unable to start ${servername}"
        sleep 1
        if [ -s "${scriptlogdir}/.${servicename}-tmux-error.tmp" ]; then
            fn_print_fail_nl "Unable to start ${servername}: Tmux error:"
            fn_script_log_fatal "Unable to start ${servername}: Tmux error:"
            echo ""
			echo "Command"
			echo "================================="
			echo "tmux new-session -d -s \"${servicename}\" \"${executable} ${parms}\"" | tee -a "${scriptlog}"
			echo ""
			echo "Error"
			echo "================================="
			cat "${scriptlogdir}/.${servicename}-tmux-error.tmp" | tee -a "${scriptlog}"
	    fi
	else
			fn_print_ok "${servername}"
			fn_script_log_pass "Started ${servername}"
			rm "${scriptlogdir}/.${servicename}-tmux-error.tmp"
			echo -en "\n"
    fi
}

fn_start_tmux
