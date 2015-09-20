# shell variables
export BROWSER='firefox'
export PAGER=less
export LESS='-iMSx4 -FX -R'
export EDITOR=vim
export TERM=xterm-256color
export HISTSIZE=5000
export HISTFILESIZE=1000
export HISTIGNORE="&:ls:ll:lt:la:l:pwd:exit:clear"
export ERL_LIBS=/home/jip/projects/erlang_libs

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# use perlbrew
if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi

# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history

# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete

# ^l clear screen
bind -m vi-insert "\C-l":clear-screen

psgrep() {
    if [ ! -z $1 ] ; then
        echo "grepping for process matching $1..."
        ps aux | grep -v grep | ack-grep $1
    else
        echo "need name to grep for"
    fi
}

bu() {
    cp $1 ~/.backup/`basename $1`-`date +%Y%m%d%H%M`.backup ;
}

