#!/bin/bash

# In my case I have a pro Dropbox account, that by default
# has the name of my business
dropbox_folder=$(find ~ -maxdepth 1 -type d -name 'Dropbox*')

echo "Copying from Dropbox the SSH keys..."
mkdir -p ~/.ssh
cp -r "$drobox_folder"/documents/password/ssh/* ~/.ssh
chmod 600 ~/.ssh/*
eval $(ssh-agent)
