# krow's bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History variables
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# Check the window size after each command.
shopt -s checkwinsize

# Make less more friendly for non-ascii input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set root or user prompt. 
if [ $(id -u) -eq 0 ];
then # Root
    PS1="\n\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\w\[\e[31m\]\n\[\e[m\]\[\e[m\]\[\e[31m\]=>\[\e[m\]\[\e[31m\] \[\e[m\]"
else # User
    PS1="\n\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\w\[\e[36m\]\n\[\e[m\]\[\e[m\]\[\e[36m\]->\[\e[m\]\[\e[36m\] \[\e[m\]"
fi

# Enable color support of some commands.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Gets specified interface IP address
getip () {
   ip addr show $1 | grep -oP "(?<=inet\s)\d+(\.\d+){3}"
}

# Alias definitions stored in ~/.bash_aliases.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Checks if tmux is available to use, and launches a main session.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main 
fi
