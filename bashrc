# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#      _               _
#     | |__   __ _ ___| |__  _ __ ___
#     | '_ \ / _` / __| '_ \| '__/ __|
#    _| |_) | (_| \__ \ | | | | | (__
#   (_)_.__/ \__,_|___/_| |_|_|  \___|
#
# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


# Environment variable
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# Prompt String (PS1)
# This would work properly in the case of colored and non-colored terminal
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]]; then
        PS1='\[\e[1;31m\]\h\[\e[0;37m\]'
    else
        PS1='\[\e[1;32m\]\u@\h\[\e[0;37m\]'
    fi
    PS1='${debian_chroot:+($debian_chroot)}'$PS1' : \[\e[1;34m\]\w $(git_branch)\n\[\e[1;35m\]\$\[\e[00m\] '

    alias ls='ls --color=auto'
    alias grep='grep --colour=auto'
else
    if [[ ${EUID} == 0 ]]; then
        PS1='\u@\h : \W\n\$ '
    else
        PS1='\u@\h : \w\n\$ '
    fi
    PS1='${debian_chroot:+($debian_chroot)}'$PS1
fi


# Internal variable, not an environment variable on history
HISTSIZE=65536
HISTFILESIZE=65536
HISTCONTROL=ignoreboth
HISTIGNORE='ls:la:ll:l:'
HISTIGNORE=$HISTIGNORE$'cd*:fg*:bg*:'
HISTIGNORE=$HISTIGNORE$'pushd*:popd*:dirs:'
HISTIGNORE=$HISTIGNORE$'clear:reset:'
HISTIGNORE=$HISTIGNORE$'history*:exit*:'
HISTIGNORE=$HISTIGNORE$'vi:vim:emacs:'
HISTIGNORE=$HISTIGNORE$'gnome*:'
HISTTIMEFORMAT='%y-%m-%d %T '


# Functions
## Show previous histories (up to 30)
## if a argument is specified, search previous 1000 histories for it
i() {
    if [ "$1" ]; then
        history 1000 | grep "$@"
    else
        history 30
    fi
}

## Show previous histories
## if a argument is specified, search all the previous histories for it
I() {
    if [ "$1" ]; then
        history | grep "$@"
    else
        history 30
    fi
}

runmatlab() {
    if [ $# -ne 1 ]; then
        echo Usage: runmatlab filename.m
    else
        /opt/matlab/r2014a/bin/matlab -nodesktop -nodisplay -nosplash -r "run('$1'); exit;"
    fi
}


# Configuration list of shopts
## though input is only directory name without cd, change directory there
shopt -s autocd
## if target of cd is not found, evaluate it as variable and change directory there
shopt -u cdable_vars
## minor errors in the spelling of a directory component in a cd command will be corrected
shopt -s cdspell
## bash checks that a command found in the hash table exists before trying to execute it
shopt -s checkhash
## bash lists the status of any stopped and running jobs before exiting an interactive shell
shopt -s checkjobs
## check the window size after each command and, if necessary, update $LINES and $COLUMNS
shopt -s checkwinsize
## bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
## bash includes filenames beginning with a `.' in the results of pathname expansion
shopt -s dotglob
## the extended pattern matching features described in man page under Pathname Expansion are enabled
shopt -s extglob
## ** used in a pathname expansion context will match all files and zero or more directories and subdirectories
shopt -s globstar
## the history list is appended to HISTFILE when the shell exits, rather than overwriting the file
shopt -s histappend
## a user is given the opportunity to re-edit a failed history substitution
shopt -s histreedit
## when use ! command, show and confirm executed command before it would be run
shopt -s histverify
## bash will not attempt to search the PATH for completions when completion is attempted on an empty line
shopt -s no_empty_cmd_completion
## case-sensitive when pathname expansion of wildcard
shopt -u nocaseglob
## case-sensitive when pattern matching (case or [[ conditional command)
shopt -u nocasematch


# Alias
case "$(uname -s 2> /dev/null)" in
    Linux*)
        alias ls='ls --color=auto'
        alias tmux='tmux -2'
        ;;
    Darwin*)
        if [ -z "${PATH##*gnu*}" ]; then
            alias ls='ls --color=auto'
        else
            alias ls='ls -G'
        fi
        ;;
esac
alias grep='grep --colour=auto'
alias l='ls -F'
alias la='ls -A'
alias ll='ls -AlF'
alias pathlist='echo -e ${PATH//:/\\n}'


# Enable forward searching for history with ^S
# check key-assignment with `stty -a`, and verify ^S is assigned to stop
stty stop undef


# Enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -r /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -r /etc/bash_completion ]; then
        source /etc/bash_completion
    elif [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
        source /usr/local/etc/profile.d/bash_completion.sh
    fi
fi
