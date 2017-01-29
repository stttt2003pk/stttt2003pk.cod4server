#!/usr/bin/env bash

#Author: stttt2003pk
#Description: start the cod4 server into tmux
#

#check if the server is running
#parms like "+set sv_punkbuster 0 +set fs_basepath ${filesdir} +set dedicated 1 +set net_ip ${ip} +set net_port ${port} +set sv_maxclients ${maxclients} +exec ${servercfg} +map ${defaultmap}"
#cd {filesdir} && {executable} +set sv_punkbuster 0 +set fs_basepath ${filesdir} +set dedicated 1 +set net_ip ${ip} +set net_port ${port} +set sv_maxclients ${maxclients} +exec ${servercfg} +map ${defaultmap}