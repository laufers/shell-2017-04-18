#!/bin/bash

# Define variables

HTML="full_terminal.html"
ANSI="full_terminal.script"
ANSI_DIR="full_terminal.d"
ANSI2HTML_OPTIONS="--bg=dark"


# Define functions

function do_file {
  # convert single file to html
  if [ ${ANSI} -nt ${HTML} ]; then 
    cat ${ANSI} | bash ansi2html.sh ${ANSI2HTML_OPTIONS} > ${HTML}
  fi
}

function do_dir {
  # convert files in directory full_terminal.d to html
  if [ ${ANSI_DIR} -nt ${HTML} ]; then
    # files are named numerically with leading zeros 
    # so they should glob in the correct order
    cat ${ANSI_DIR}/* | bash ansi2html.sh ${ANSI2HTML_OPTIONS} > ${HTML}
  fi
}


# Main code

if [ ${ANSI} -nt ${ANSI_DIR} ]; then
  # must be using script, convert single file
  do_file
elif [ ${ANSI_DIR} -nt ${ANSI} ]; then
  # must be using mintty log, convert directory
  do_dir
else
  # presumably neither ${ANSI} nor ${ANSI_DIR} exists 
  # (or they were modified at exactly the same time)
  # Do nothing
fi
