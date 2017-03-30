#!/bin/bash

# Define variables

HTML="full_terminal.html"
ANSI="full_terminal.script"
ANSI_DIR="full_terminal.d"
ANSI2HTML_OPTIONS="--bg=dark"

ANSI_DIR_NEWEST=""  # newest file in ${ANSI_DIR}
if [ -d ${ANSI_DIR} ]; then
  ANSI_DIR_NEWEST="$(ls -1t ${ANSI_DIR}/[0-9][0-9][0-9] | head -1)"
fi


# Define functions

function do_file {
  # convert single file to html
  if [ ${ANSI} -nt ${HTML} ]; then 
    cat ${ANSI} | ./ansi2html.sh ${ANSI2HTML_OPTIONS} > ${HTML}
  fi
}

function do_dir {
  # convert files in directory full_terminal.d to html
  if [ ${ANSI_DIR_NEWEST} -nt ${HTML} ]; then
    # files are named numerically with leading zeros 
    # so they should glob in the correct order
    cat ${ANSI_DIR}/* | ./ansi2html.sh ${ANSI2HTML_OPTIONS} > ${HTML}
  fi
}


# Main code

# Make ansi2html script directly executable since calling it as
# an argument to bash doesn't work right on Mac
if [ ! -x ansi2html.sh ]; then
  chmod +x ansi2html.sh
fi

if [ ${ANSI} -nt ${ANSI_DIR_NEWEST} ]; then
  # must be using script, convert single file
  do_file
elif [ ${ANSI_DIR_NEWEST} -nt ${ANSI} ]; then
  # must be using mintty log, convert directory
  do_dir
else
  # presumably neither ${ANSI} nor ${ANSI_DIR} exists 
  # (or they were modified at exactly the same time)
  # Do nothing
  :
fi
