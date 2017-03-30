#!/bin/bash
#
# Set the environment for the instructor's bash shell.
#

# Get the path of the directory that contains this script.
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Inherit everything from transcript.bashrc
source "${REPO_PATH}/transcript.bashrc"

# Set the prompt string. Keep it short by excluding the working directory
# so the learners don't have a hard time following the commands you enter.
export PS1="$ "

