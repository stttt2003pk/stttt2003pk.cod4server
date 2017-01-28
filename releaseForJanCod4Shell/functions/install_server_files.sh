#!/usr/bin/env bash
#Author: stttt2003pk
#Description: Installs server files
fn_install_server_files() {
    fileurl="http://files.gameservermanagers.com/CallOfDuty4/cod4x18_dedrun.tar.bz2";
    filedir="${tmpdir}";
    filename="cod4x18_dedrun.tar.bz2";
    executecmd="noexecute";
    run="norun";
    force="noforce";
    md5="bebdfc1755626462bdaad49f6f926c08"

    fn_fetch_file "${fileurl}" "${filedir}" "${filename}" "${executecmd}" "${run}" "${force}" "${md5}"
    fn_dl_extract "${filedir}" "${filename}" "${filesdir}"
}

echo ""
echo "Installing ${gamename} Server"
echo "================================="
#echo "${autoinstall}"
#echo "${getopt}"

fn_install_server_files

echo "$(whoami)"
file_user="$(whoami)"
echo "================================="
echo "Change the role to the server files"
chowncmd=$(chown -R "${file_user}:${file_user}" "${filesdir}/")

if [ $? != 0 ]; then
    echo "Change Own Failed"
else
    echo "Change Own Success"
fi

if [ -z "${autoinstall}" ]; then
    echo ""
	echo "================================="
	while true; do
	    read -e -i "y" -p "Was the install successful? [Y/n]" yn
	    case ${yn} in
	        [Yy]* ) break;;
	        [Nn]* )
	            echo "installation failed";
	            break;;
	        * ) echo "Please answer yes or no.";;
	    esac
	done

fi

