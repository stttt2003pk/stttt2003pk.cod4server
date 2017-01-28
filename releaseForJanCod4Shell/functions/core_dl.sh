#!/usr/bin/env bash

#Author: stttt2003pk
#Description: Deals with all downloads

# filedir: location the file is to be saved: ./tmp
# filename: name of file (this can be different from the url name): file.tar.bz2
# executecmd: Optional, set to "executecmd" to make file executable using chmod +x
# run: Optional, set to run to execute the file
# force: Optional, force re-download of file even if exists
# md5: Optional, Checks file against an md5 sum

# Downloads can be defined in code like so:
# fn_fetch_file "${fileurl}" "${filedir}" "${filename}" "${executecmd}" "${run}" "${force}" "${md5}"
# fn_fetch_file "http://example.com/file.tar.bz2" "/some/dir" "file.tar.bz2" "executecmd" "run" "force" "10cd7353aa9d758a075c600a6dd193fd"

fn_fetch_file(){
	fileurl="${1}"
	filedir="${2}"
	filename="${3}"
	executecmd="${4:-0}"
	run="${5:-0}"
	force="${6:-0}"
	md5="${7:-0}"

	# If the file is missing, then download
	if [ ! -f "${filedir}/${filename}" ]; then
		if [ ! -d "${filedir}" ]; then
			mkdir -p "${filedir}"
		fi

		# Check curl exists and use available path
		curlpaths="$(command -v curl 2>/dev/null) $(which curl >/dev/null 2>&1) /usr/bin/curl /bin/curl /usr/sbin/curl /sbin/curl)"
		for curlcmd in ${curlpaths}
		do
			if [ -x "${curlcmd}" ]; then
				break
			fi
		done
		# If curl exists download file
		if [ "$(basename ${curlcmd})" == "curl" ]; then
			# trap to remove part downloaded files
			trap fn_fetch_trap INT
			# if larger file shows progress bar
			if [ ${filename##*.} == "bz2" ]||[ ${filename##*.} == "jar" ]; then
				echo -ne "downloading ${filename}..."
				sleep 1
				curlcmd=$(${curlcmd} --progress-bar --fail -L -o "${filedir}/${filename}" "${fileurl}")
				echo -ne "downloading ${filename}..."
			else
				echo -ne "    fetching ${filename}...\c"
				curlcmd=$(${curlcmd} -s --fail -L -o "${filedir}/${filename}" "${fileurl}" 2>&1)
			fi
			local exitcode=$?
			if [ ${exitcode} -ne 0 ]; then
				fn_print_fail_eol_nl
				if [ -f "${scriptlog}" ]; then
					fn_script_log_fatal "downloading ${filename}: FAIL"
				fi
				echo -e "${fileurl}" | tee -a "${scriptlog}"
				echo "${curlcmd}" | tee -a "${scriptlog}"
				core_exit.sh
			else
				fn_print_ok_eol_nl
				if [ -f "${scriptlog}" ]; then
					fn_script_log_pass "downloading ${filename}: OK"
				fi
			fi
			# remove trap
			trap - INT
		else
			fn_print_fail_eol_nl
			echo "Curl is not installed!"
			echo -e ""
			if [ -f "${scriptlog}" ]; then
				fn_script_log_fatal "Curl is not installed!"
			fi
			core_exit.sh
		fi
		# make file executecmd if executecmd is set
		if [ "${executecmd}" == "executecmd" ]; then
			chmod +x "${filedir}/${filename}"
		fi
	fi

	if [ -f "${filedir}/${filename}" ]; then
		#fn_dl_md5
		# run file if run is set
		if [ "${run}" == "run" ]; then
			source "${filedir}/${filename}"
		fi
	fi
}

# Extracts bzip2 or gzip or zip files
# Extracts can be defined in code like so:
# fn_dl_extract "${filedir}" "${filename}" "${extractdir}"
# fn_dl_extract "/home/gameserver/lgsm/tmp" "file.tar.bz2" "/home/gamserver/serverfiles"
fn_dl_extract(){
	filedir="${1}"
	filename="${2}"
	extractdir="${3}"
	echo -ne "extracting ${filename}..."
	fn_script_log_info "Extracting download"
	mime=$(file -b --mime-type "${filedir}/${filename}")

	if [ "${mime}" == "application/gzip" ]||[ "${mime}" == "application/x-gzip" ]; then
		tarcmd=$(tar -zxf "${filedir}/${filename}" -C "${extractdir}")
	elif [ "${mime}" == "application/x-bzip2" ]; then
		tarcm=$(tar -jxf "${filedir}/${filename}" -C "${extractdir}")
	elif [ "${mime}" == "application/zip" ]; then
		tarcmd=$(unzip -d "${extractdir}" "${filedir}/${filename}")
	fi
	exitcode=$?

	if [ ${exitcode} -ne 0 ]; then
		fn_print_fail_eol_nl
		fn_script_log_fatal "Extracting download: FAIL"
		echo "${tarcmd}" | tee -a "${scriptlog}"
		core_exit.sh
	else
		fn_print_ok_eol_nl
	fi
}

#trap to remove file download if cancled by Ctrl+c
fn_fetch_trap(){
	echo ""
	echo -ni "downloading ${filename}:"
	fn_print_canceled_eol_nl
	fn_script_log_info "downloading ${filename} CANCLED"
	sleep 1
	rm -f "${filedir}/${filename}" | tee -a "${scriptlog}"
	echo -ne "downloading ${filename}: "
	fn_print_removed_eol_nl
	fn_script_log_info "downloading ${filename}: Removed"
	core_exit.sh
}






















































