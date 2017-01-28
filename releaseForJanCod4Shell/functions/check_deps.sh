#!/usr/bin/env bash
#Author: stttt2003pk
#Description: check the cstrike server need
array_deps_missing=()
array_deps_required=(curl wget util-linux python file gzip bzip2 \
                    tmux \
                    glibc.i686 libstdc++.i686 \
                    compat-libstdc++-33.i686 \
                    )

fn_check_loop() {
    for deptocheck in "${array_deps_required[@]}"
    do
        fn_deps_detector
    done
}

fn_deps_detector() {
    #yum to check the dependencies
    if [ -n "$(command -v yum)" ]; then
        yum -q list installed ${deptocheck} > /dev/null 2>&1
        depstatus=$?
    fi

    #show if dependency is found
    if [ "${depstatus}" == "0" ]; then
        missingdep=0
        echo -e "${green}${deptocheck}${default}"
        sleep 0.5
    else
        missingdep=1
        echo -e "${red}${deptocheck}${default}"
         sleep 0.1
    fi

    if [ "${missingdep}" == 1 ]; then
        array_deps_missing+=("${deptocheck}")
    fi

}

function fn_found_missing_deps() {
    if [ "${#array_deps_missing[@]}" != "0" ]; then
        fn_print_dots "Checking dependencies"
        sleep 0.5
        fn_print_error_nl "Checking dependencies: missing: ${red}${array_deps_missing[@]}${default}"
        fn_script_log_error "Checking dependencies: missing: ${red}${array_deps_missing[@]}${default}"
        if [ -n "$(command -v yum)" ]; then
            cmd="yum install -y ${array_deps_missing[@]}"
            eval ${cmd}
        fi

        if [ $? != 0 ]; then
            fn_print_failure_nl "Unable to install dependencies"
            fn_script_log_fatal "Unable to install dependencies"
        else
            fn_print_complete_nl "Install dependencies completed"
            fn_script_log_pass "Install dependencies completed"
        fi
        echo -e "${green}${array_deps_required[@]} all ok ${default}"
    fi
}

# Generate array of missing deps
fn_check_loop
fn_found_missing_deps