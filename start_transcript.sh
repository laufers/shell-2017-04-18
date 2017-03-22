#!/bin/bash

# Get the path of the directory that contains this script.
REPO_PATH="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Launch an xterm running the auto_push script
# Note: auto_push.sh also converts script's transcript to html using the ansi2html script
xterm -e "cd ${REPO_PATH}; bash auto_push.sh" &

# Use the script command to record a transcript
script -aq -c "bash --rcfile \"${REPO_PATH}/transcript.bashrc\"" -f "${REPO_PATH}/full_terminal.script"
