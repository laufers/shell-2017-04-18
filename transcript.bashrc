
# Set the environment for the instructor's bash shell.
#

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
elif [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
elif [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

case "$(uname -s)" in
  Darwin)
    alias ls='ls -G'
    ;;
  *)
    alias ls='ls --color=auto'
    ;;
esac

# Get the path of the directory that contains this script.
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# This causes the last command entered to be appended to the commands.txt file.
# The PROMPT_COMMAND is executed by bash every time before displaying your prompt.
export PROMPT_COMMAND="history 1 | sed -E 's/^\ *[0-9]+\ +//' >> ${REPO_PATH}/commands.txt"

