#!/usr/bin/env bash

#Author: stttt2003pk
#Description: declare just variables and functions for the program
#warning:no exec scripts in this file

# Server Details
servicename="cod4-server"
# In call of duty 4 servername = servicename
servername=${servicename}
gamename="Call of Duty 4"
engine="iw3.0"
version="170110"

# Directories
rootdir="$(dirname $(readlink -f "${BASH_SOURCE[0]}"))"
selfname="$(basename $(readlink -f "${BASH_SOURCE[0]}"))"
functionsdir="${rootdir}/functions"
filesdir="${rootdir}/serverfiles"
configdir="${rootdir}/server_config"
systemdir="${filesdir}"

tmp_dir="${rootdir}/tmp"
tmpdir="${filesdir}/tmp"

#cfg
servercfg="${servicename}.cfg"
servercfgdir="${systemdir}/main"
servercfgfullpath="${servercfgdir}/${servercfg}"
servercfgdefault="server.cfg"
executabledir="${filesdir}"
executable="./cod4x18_dedrun"
#echo $filesdir

# Logging
logdays="7"
gamelogdir="${rootdir}/logs"
scriptlogdir="${rootdir}/log/script"
consolelogdir="${rootdir}/log/console"
consolelog="${consolelogdir}/${servicename}-console.log"

scriptlog="${scriptlogdir}/${servicename}-script.log"

scriptlogdate="${scriptlogdir}/${servicename}-script-$(date '+%d-%m-%Y-%H-%M-%S').log"

#executable

executable="./cod4x18_dedrun"
ip="0.0.0.0"
port="28960"
clientport="27005"
defaultmap="mp_crossfire"
maxplayers="32"