#!/usr/bin/env bash
#
# Copyright (C) 2023 BlackMesa123
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

# shellcheck disable=SC1091,SC2012,SC2034

set -o allexport
source $SRC_DIR/scripts/internal/writeput.sh

# [
SRC_DIR="$(git rev-parse --show-toplevel)"
OUT_DIR="$SRC_DIR/out"
TMP_DIR="$OUT_DIR/tmp"
ODIN_DIR="$OUT_DIR/odin"
FW_DIR="$OUT_DIR/fw"
APKTOOL_DIR="$OUT_DIR/apktool"
WORK_DIR="$OUT_DIR/work_dir"
TOOLS_DIR="$OUT_DIR/tools/bin"

PATH="$TOOLS_DIR:$PATH"

run_cmd()
{
    source $SRC_DIR/scripts/internal/writeput.sh
    local CMD=$1
    local CMDS
    CMDS="$(ls --ignore "internal" "$SRC_DIR/scripts" | sed "s/.sh//")"
    if [ -z "$CMD" ] || [ "$CMD" = "-h" ]; then
        echo "Available cmds:\n$CMDS"
        return 1
    elif ! echo "$CMDS" | grep -q -w "$CMD"; then
        echo_err "\"$CMD\" is not valid."
        echo "Available cmds:\n$CMDS"
        return 1
    else
        shift
        bash -e "$SRC_DIR/scripts/$CMD.sh" "$@"
    fi
}
# ]

TARGETS="$(ls "$SRC_DIR/target")"

if [ "$#" != 1 ]; then
    echo "Usage: source buildenv.sh <target>"
    echo -e "Available devices:\n$TARGETS"
    return 1
elif ! echo "$TARGETS" | grep -q -w "$1"; then
    echo_err "\"$1\" is not valid target."
    echo -e "Available devices:\n$TARGETS"
    return 1
else
    mkdir -p "$OUT_DIR"
    run_cmd build_dependencies || return 1
    [ -f "$OUT_DIR/config.sh" ] && unset $(sed "/Automatically/d" "$OUT_DIR/config.sh" | cut -d= -f1)
    bash "$SRC_DIR/scripts/internal/gen_config_file.sh" "$1" || return 1
    source "$OUT_DIR/config.sh"

    echo "=============================="
    sed "/Automatically/d" "$OUT_DIR/config.sh"
    echo "=============================="
fi

unset TARGETS
set +o allexport

return 0
