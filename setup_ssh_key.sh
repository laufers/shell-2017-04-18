#!/bin/bash

# Generate an ssh key for github if it doesn't already exist
if [ ! -f ~/.ssh/github.key ]; then
  ssh-keygen -t rsa -N "" -f ~/.ssh/github.key
fi

# Set this new ssh key to be used for github.com if it's not already 
# setup in ~/.ssh/config
if [[ ! -f ~/.ssh/config || ! $(grep -q ^Host\ github.com ~/.ssh/config; echo $?) ]]; then
  # Add entry to ~/.ssh/config
  echo "Host github.com" >> ~/.ssh/config
  echo "    IdentityFile ~/.ssh/github.key" >> ~/.ssh/config
fi

# Add github.com's host key to your known_hosts file if it's not 
# already in there
grep -q 'github.com' ~/.ssh/known_hosts || ssh-keyscan github.com >> ~/.ssh/known_hosts

