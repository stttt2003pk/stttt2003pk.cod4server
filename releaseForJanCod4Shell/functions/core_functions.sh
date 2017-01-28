#!/usr/bin/env bash

#Author: stttt2003pk
#Description: Defines all functions to allow download and execution of functions using fn_fetch_function
#Used: should be included into core_opt.sh

command_install.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}
command_start.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}
command_stop.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}
check_deps.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}

check_steamcmd.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}

install_server_files.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}
install_config.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}

core_exit.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}

fix.sh(){
	functionfile="${FUNCNAME}"
	source ${functionsdir}/${functionfile}
}

fn_autoinstall(){
    autoinstall=1
    command_install.sh
}


