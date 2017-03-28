#!/bin/bash
#
# Set the environment for the instructor's bash shell.
#

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
elif [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
fi

alias ls='ls --color=auto'

# Get the path of the directory that contains this script.
REPO_PATH="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# This causes the last command entered to be appended to the commands.txt file.
# The PROMPT_COMMAND is executed by bash every time before displaying your prompt.
export PROMPT_COMMAND="history 1 | sed 's/^\ *[0-9]\+\ \+//' >> ${REPO_PATH}/commands.txt"

# Set the prompt string. Keep it short by excluding the working directory
# so the learners don't have a hard time following the commands you enter.
export PS1="$ "

