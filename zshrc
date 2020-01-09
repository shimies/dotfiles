# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#              _
#      _______| |__  _ __ ___
#     |_  / __| '_ \| '__/ __|
#    _ / /\__ \ | | | | | (__
#   (_)___|___/_| |_|_|  \___|
#
# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


# Environment variable
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8


# Changing directories
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
setopt pushd_ignore_dups


# Completion
setopt always_last_prompt
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash


# Expansion and globbing
setopt extended_glob
setopt magic_equal_subst
setopt mark_dirs


# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=0xfffffff
SAVEHIST=$HISTSIZE

setopt append_history
setopt bang_hist                 # Treat the '!' character specially during expansion
setopt extended_history          # Write the history file in the ":start:elapsed;command" format
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history
setopt hist_find_no_dups         # Do not display a line previously found
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate
setopt hist_ignore_dups          # Don't record an entry that was just recorded again
setopt hist_ignore_space         # Don't record an entry starting with a space
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry
setopt hist_save_no_dups         # Don't write duplicate entries in the history file
setopt hist_verify               # Don't execute immediately upon history expansion
setopt inc_append_history        # Write to the history file immediately, not when the shell exits
setopt share_history             # Share history between all sessions


# Input/Output
setopt correct


# Job control
setopt check_jobs
setopt hup


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


# Keybindings
bindkey -d  # Reset all keybindings
bindkey -e  # Use emacs keybindings even if our EDITOR is set to vi
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[3~' delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

## Enable forward searching for history with ^S
## check key-assignment with `stty -a`, and verify ^S is assigned to stop
stty stop undef

function _git_status() {
    if [ $(command git rev-parse --is-inside-work-tree 2> /dev/null) = 'true' ]; then
        echo 'git status -b --porcelain'
        git status -b --porcelain
    fi
    zle reset-prompt
}
zle -N git_status _git_status  # register _git_status function as git_status widget
bindkey '^G^S' git_status


# Hook functions
function chpwd() {
    emulate -L zsh  # reset options that have been set by users
    ls -A
}


# --------------------------------------------------
#  Completion settings by zstyle
# --------------------------------------------------
zstyle ':completion:*' menu select=2
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# set colors
if type dircolors 1>/dev/null 2>&1; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"
else
    export CLICOLOR=1
    zstyle ':completion:*:default' list-colors ''
fi

# message format colored
zstyle ':completion:*:corrections' format '%B%F{yellow}%d%f %F{red}(errors: %e)%f%b'
zstyle ':completion:*:descriptions' format '%B%F{yellow}completing %d%f%b'
zstyle ':completion:*:messages' format '%B%F{yellow}%d%f%b'
zstyle ':completion:*:warnings' format '%B%F{red}no matches for:%f %F{yellow}%d%f%b'

# for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# virtualenvwrapper.sh
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi



# --------------------------------------------------
#  Load functions supplied by the distribution
# --------------------------------------------------
## Enable colors
autoload -Uz colors
colors

## Use modern completion system
autoload -Uz compinit
compinit

## Prompt setting
autoload -Uz promptinit
promptinit
prompt adam1 blue cyan green

## Prompt for version control system
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

RPROMPT=""

# Export three messages shown below
# - $vcs_info_msg_0_, for normal messages (green)
# - $vcs_info_msg_1_, for warning messages (yellow)
# - $vcs_info_msg_2_, for error messages (red)

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git svn hg bzr

# Set common format for each vcs except git
#   %s, name of vcs
#   %b, branch information
#   %r, name of repository
#   %a, name of action e.g. merge
#   %m, other information
zstyle ':vcs_info:*' formats '%s:(%b)'
zstyle ':vcs_info:*' actionformats '%s:(%b)' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

if is-at-least 4.3.10; then
    # Set formats for git
    #   %c, value specified by stagedstr, hook_com[staged]
    #   %u, value specified by unstagedstr, hook_com[unstaged]
    zstyle ':vcs_info:git:*' formats '%s:(%b)' '[%c%u]%m'
    zstyle ':vcs_info:git:*' actionformats '%s:(%b)' '[%c%u]%m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
fi

if is-at-least 4.3.11; then
    # Set formats for git using hook functions
    #   each hook function is called on every message on either formats or actionformats
    #   in other words, at most they are called three times since actionformats takes three messages
    zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked git-push-status git-nomerge-branch git-stash-count

    # first hook function
    # whose behavior is to determine if it is inside a working tree
    function +vi-git-hook-begin()
    {
        if [ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]; then
            return 1  # prevent following hook functions from being called
        else
            return 0  # proceed following hook functions
        fi
    }

    # hook function for untracked files
    # which additionally prints '?' if there is an untracked file
    function +vi-git-untracked()
    {
        # proceed only if this is for the second message for either formats or actionformats
        if [ "$1" != "1" ]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null | command grep -F '??' >/dev/null 2>&1 ; then
            hook_com[unstaged]+='?'
        fi
    }

    # hook function for unpushed commits
    # which additionally prints '(pN)' where N is the number of unpushed commits
    function +vi-git-push-status()
    {
        if [ "$1" != "1" ]; then
            return 0
        fi

        # do nothing if it is not master branch
        if [ "${hook_com[branch]}" != "master" ]; then
            return 0
        fi

        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null | wc -l | tr -d ' ')
        if [[ "$ahead" -gt 0 ]]; then
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # hook function for unmerged commits
    # which additionally prints '(mN)' where N is the number of unmerged commits
    function +vi-git-nomerge-branch()
    {
        if [ "$1" != "1" ]; then
            return 0
        fi

        # do nothing if it is master branch
        if [ "${hook_com[branch]}" = "master" ]; then
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')
        if [ "$nomerged" -gt 0 ]; then
            hook_com[misc]+="(m${nomerged})"
        fi
    }

    # hook function for stash
    # which additionally prints ':SN' where N is the number of stash entries
    function +vi-git-stash-count()
    {
        if [ "$1" != "1" ]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [ "${stash}" -gt 0 ]; then
            hook_com[misc]+=":S${stash}"
        fi
    }
fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US vcs_info

    if [ -z ${vcs_info_msg_0_} ]; then
        # if not configured by vcs_info i.e. the string has zero length
        prompt=""
    else
        # if configured, color each the vcs messages with the correspoing color
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # join those three messages with a space
        prompt="${(j: :)messages}"
    fi
    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg


# ==================================================
#  Plugins installed by zplug
# ==================================================
if [ ! -d $HOME/.zplug ]; then
    git clone https://github.com/zplug/zplug $HOME/.zplug
fi

source $HOME/.zplug/init.zsh

# Place our plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# --------------------------------------------------
# zsh-syntax-highlighting
# --------------------------------------------------
## Set highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

## main highlighter
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'
