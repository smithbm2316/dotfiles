#! /usr/bin/env fish

# help menu
function print_help
	function help_fmt -a fl description
		printf "\t$fl\t$description\n"
	end
	printf "stowdots [FLAGS]: manage symlinking of dotfiles, scripts, cronjobs, etc\n"
	help_fmt '-l/--link' 'link package (default)'
	help_fmt '-u/--unlink' 'unlink package'
	help_fmt '-h/--help' 'show this help menu'
end


set -l cmdFlags -l --link -u --unlink
set -l link -l --link
set -l unlink -u --unlink

if contains -- $argv[1] $cmdFlags
or ! count $argv > /dev/null
	set -l extraFlag ''
	if contains -- $argv[1] $link
		set extraFlag 'S'
		echo 'Files to link:'
	else if contains -- $argv[1] $unlink
		set extraFlag 'D'
		echo 'Files to unlink:'
	else
		set extraFlag 'S'
		echo 'Files to link:'
	end

	# grab most recent dir from the stack to replace
	prevd; set -l prevDir $PWD; prevd

	cd
	stow "-nv$extraFlag" --ignore='config|cronjobs|scripts|Makefile|README.md' \
		-t $XDG_CONFIG_HOME dotfiles &| sed -nr 's/U?N?LINK: //p' | sort | xargs

	echo 'Are you ready to link/unlink your dots?'
	read stowfiles
	if test $stowfiles = 'y'
		if test -d $XDG_CONFIG_HOME/fish
			rm -rf $XDG_CONFIG_HOME/fish
		end
		stow "-v$extraFlag" --ignore='config|cronjobs|scripts|Makefile|README.md' \
			-t $XDG_CONFIG_HOME dotfiles
	else
		echo 'Exiting program without modifying filesystem...'
	end

	prevd
	cd $prevDir
	prevd
else
	print_help
end
