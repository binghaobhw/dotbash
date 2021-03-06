#!/usr/bin/env bash

export BASH_CONFIG_DIR="${HOME}/.bash/config"

# Load aliases
source "${BASH_CONFIG_DIR}/bash_aliases"
source "${BASH_CONFIG_DIR}/git-completion.bash"

# Use case-insensitive filename globbing
shopt -s nocaseglob
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Set colors
reset_color='\[\e[39m\]'

black='\[\e[0;30m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
yellow='\[\e[0;33m\]'
blue='\[\e[0;34m\]'
purple='\[\e[0;35m\]'
cyan='\[\e[0;36m\]'
white='\[\e[0;37;1m\]'

function parse_git_branch {
    git symbolic-ref --short HEAD 2>/dev/null
}
# Set prompt
PS1="
${green}\w${reset_color} ${yellow}"'$(parse_git_branch)'"${reset_color} ${blue}\u${white}@${blue}\h${reset_color}
${yellow}\$${reset_color} "


export LANG="en_US.UTF-8"
