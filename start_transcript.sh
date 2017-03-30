#!/bin/bash

# Get the path of the directory that contains this script.
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


case "$1" in
  --keep-prompt)
    RCFILE="${REPO_PATH}/transcript.bashrc"
    ;;
  *)
    RCFILE="${REPO_PATH}/short_prompt.bashrc"
    ;;
esac


case "$(uname -s)" in
  Linux)
    # Launch an xterm running the auto_push script
    # Note: auto_push.sh also converts script's transcript to html using the ansi2html script
    xterm -e "cd ${REPO_PATH}; bash auto_push.sh" &

    # Use the script command to record a transcript
    script -aq -c "bash --rcfile \"${RCFILE}\"" -f "${REPO_PATH}/full_terminal.script"
    ;;

  MINGW*|CYGWIN*|MSYS*)
    # Using mintty's log option instead of script since script is not
    # included with git bash. The log option doesn't allow appending to
    # an existing file, so we're creating a directory (full_terminal.d)
    # and using log files named "000" through "999".
    mkdir -p "${REPO_PATH}/full_terminal.d"

    # Get the number of existing files. Since we're starting with 0, we
    # can use this number to name the current log file.
    num=$(find "${REPO_PATH}/full_terminal.d" -mindepth 1 -maxdepth 1 | wc -l)
    
    # Format the number with leading zeros.
    numf=$(printf "%03d" ${num})

    mintty_log="${REPO_PATH}/full_terminal.d/${numf}"

    # Launch a new window running the auto_push script.
    mintty.exe --dir "${REPO_PATH}" --exec bash auto_push.sh &

    # Launch the teaching terminal in a new window.
    mintty.exe --log "${mintty_log}" --Title "Teaching Terminal" --exec bash --rcfile "${RCFILE}"
    ;;

  Darwin)
    # The script command on Mac has different options than on Linux
    # It can only immediately flush output to a named pipe
    NAMED_PIPE="${REPO_PATH}/full_terminal.pipe"
    if [ ! -p "${NAMED_PIPE}" ]; then
      mkfifo "${NAMED_PIPE}"
    fi

    # Start a new terminal window running the auto_push script
    # First need to make the auto_push script executable
    chmod +x "${REPO_PATH}/auto_push.sh"
    open -a Terminal.app "${REPO_PATH}/auto_push.sh"

    cat "${NAMED_PIPE}" >> "${REPO_PATH}/full_terminal.script" &
    script -aq -F "${NAMED_PIPE}" bash --rcfile "${RCFILE}"
    ;;

esac
