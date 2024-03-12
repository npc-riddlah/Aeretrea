#!/usr/bin/env bash
#
# Copyright (C) 2024 npc_riddlah
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

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
