#!/usr/bin/env bash
#Author: stttt2003pk
#Description: install the config for cod4

gamedirname="CallOfDuty4"
array_configs+=( server.cfg )

defaultconfidir="${rootdir}/server_config"
defaultconfig="${defaultconfidir}/cod4-server.cfg"

servercfgfullpath="${servercfgdir}/cod4-server.cfg"

fn_cp_config_file() {
    if [ -z "${defaultconfig}" ]; then
        echo "Please Get The Default Config File"
        exit 2
    else
        if [ "${gamename}" == "Call of Duty 4" ]; then
            cp -v "${defaultconfig}" "${servercfgfullpath}"
        fi
    fi
}

fn_set_config_vars() {
    echo "Default Cod 4 Default Cfg do not need to set"
    pass
}

fn_cp_config_file