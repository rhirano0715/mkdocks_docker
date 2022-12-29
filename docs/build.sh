#!/bin/bash

readonly EXIT_SUCCESS=0
readonly EXIT_ERROR=1
readonly CURRENT_DIR=$(pwd)
readonly OWN_DIR=$(cd $(dirname $0);pwd)

function myexit() {
    local status=$1
    cd ${CURRENT_DIR}
    exit ${status}
}

function main () {
    local project_name=$1

    if [[ "${project_name}" == "" ]]; then
        echo "Usage: bash build.sh project_name"
        myexit ${EXIT_ERROR}
    fi

    local project_dir="${OWN_DIR}/${project_name}"

    if [[ ! -d ${project_dir} ]]; then
        echo "Project is not exists. ${project_dir}"
        myexit ${EXIT_ERROR}
    fi

    build "${project_dir}"

    myexit $?
}

function build () {
    local project_dir=$1

    cd ${project_dir}
    mkdocs build
    local build_status=$?
    if [[ ${build_status} -ne ${EXIT_SUCCESS} ]]; then
        return ${build_status}
    fi

    mkdocs serve
    local serve_status=$?
    if [[ ${serve_status} -ne ${EXIT_SUCCESS} ]]; then
        return ${serve_status}
    fi

    return ${EXIT_SUCCESS}
}

main ${@}
