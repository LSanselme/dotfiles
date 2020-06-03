#!/bin/bash

PROMPT='[bootstrap]'
source .exports

# Initialize a few things
init () {
	echo "$PROMPT Making a Projects folder in $PATH_TO_PROJECTS if it doesn't already exist"
	mkdir -p "$PATH_TO_PROJECTS"
	echo "$PROMPT Making a Playground folder in $PATH_TO_PLAYGROUND if it doesn't already exist"
	mkdir -p "$PATH_TO_PLAYGROUND"
}

# TODO : Delete symlinks to deleted files
# Is this where rsync shines?
# TODO - add support for -f and --force
link () {
	echo "$PROMPT This utility will symlink the files in this repo to the home directory"
	echo "$PROMPT Proceed? (y/n)"
	read resp
	# TODO - regex here?
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
		for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
			ln -svf "$PWD/$file" "$HOME"
		done
		# TODO: source files here?
		echo "$PROMPT Symlinking complete"
	else
		echo "$PROMPT Symlinking cancelled by user"
		return 1
	fi
}

init
link

