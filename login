#!/bin/bash

if [ ! -d "$HOME/.ssh/" ]; then
	# In my case I have a pro Dropbox account, that by default
	# has the name of my business
	dropbox_folder=$(find ~ -maxdepth 1 -type d -name 'Dropbox*')

	echo "Copying from Dropbox the SSH keys..."
	mkdir "$HOME/.ssh"
	cp -r "$drobox_folder"/documents/password/ssh/* ~/.ssh
	chmod 600 ~/.ssh/*
	eval $(ssh-agent)
fi

if [ ! -d "$HOME/.dotfiles.git/" ]; then
        echo "Setup dotfiles..."
	dots="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
        git clone --recursive --separate-git-dir=$HOME/.dotfiles.git git@github.com:matjack1/dotfiles.git /tmp/dots
	rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
	rm -r /tmp/dots
	$dots submodule update --init --recursive $HOME/
	$dots config status.showUntrackedFiles no
	# Useful aliases
	$dots config alias.untracked "status -u ."
	$dots config alias.untracked-at "status -u"
fi

