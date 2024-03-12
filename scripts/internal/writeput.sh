#!/bin/bash

COL_RED='\033[0;31m'
COL_GREEN='\033[0;32m'
COL_YELLOW='\033[0;33m'
COL_RESET='\033[0m'

function echo_err(){
	printf "\n${COL_RED}[ERROR!]${COL_RESET} $1\n"
}

function echo_info(){
	printf "${COL_GREEN}[INFO]${COL_RESET} $1\n"
}

function echo_warn(){
	printf "\n${COL_YELLOW}[WARNING]${COL_RESET} $1\n"
}

function echo_ok(){
	printf "${COL_GREEN}[OK]${COL_RESET} $1\n"
}

function echo_no(){
	printf "${COL_RED}[NO]${COL_RESET} $1\n"
}
