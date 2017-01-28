#!/usr/bin/env bash
#Author: stttt2003pk
#Description: core operation choice

#include:
source ./var.sh
source ./functions/core_functions.sh
source ./functions/core_dl.sh
source ./functions/core_message.sh

fn_getopt_generic(){
    case "${getopt}" in
        i|install)
		    command_install.sh;;
		ai|auto-install)
		    fn_autoinstall;;
	    st|start)
		    command_start.sh;;
	    sp|stop)
		    command_stop.sh;;
	    *)
	    if [ -n "${getopt}" ]; then
		    echo -e "${red}Unknown command${default}: $0 ${getopt}"
		    exitcode=2
	    fi
	    echo "Usage: $0 [option]"
	    echo "${gamename} - Cod4 Linux Server Manager - Version ${version}"
	    echo -e ""
	    echo -e "${lightyellow}Commands${default}"
	    {
	    	echo -e "${blue}start\t${default}st |Start the server."
	    	echo -e "${blue}stop\t${default}sp |Stop the server."
	    	#echo -e "${blue}restart\t${default}r  |Restart the server."
	    	echo -e "${blue}install\t${default}i  |Install the server."
	    	echo -e "${blue}auto-install\t${default}ai  |Install the server."
	    } | column -s $'\t' -t
	esac
}

getopt=$1

fn_getopt_generic