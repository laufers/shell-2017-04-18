#!/bin/bash

# Get the path of the directory that contains this script.
REPO_PATH="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

case "$(uname -s)" in
  Linux)
    # Launch an xterm running the auto_push script
    # Note: auto_push.sh also converts script's transcript to html using the ansi2html script
    xterm -e "cd ${REPO_PATH}; bash auto_push.sh" &

    # Use the script command to record a transcript
    script -aq -c "bash --rcfile \"${REPO_PATH}/transcript.bashrc\"" -f "${REPO_PATH}/full_terminal.script"
    ;;

  MINGW*|CYGWIN*|MSYS*)
    mkdir -p "${REPO_PATH}/full_terminal.d"
    num=$(find "${REPO_PATH}/full_terminal.d" -mindepth 1 -maxdepth 1 | wc -l)
    numf=$(printf "%03d" ${num})
    mintty_log="${REPO_PATH}/full_terminal.d/${numf}"
    mintty.exe --dir "${REPO_PATH}" --exec bash auto_push.sh &
    mintty.exe --log "${mintty_log}" --exec bash --rcfile "${REPO_PATH}/transcript.bashrc"
    ;;

esac
