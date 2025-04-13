# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#              _
#      _______| |__  _ __ ___
#     |_  / __| '_ \| '__/ __|
#    _ / /\__ \ | | | | | (__
#   (_)___|___/_| |_|_|  \___|
#
# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


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
bindkey '^[[Z' reverse-menu-complete  # Shift + Tab
bindkey '^[[3~' delete-char           # Delete
bindkey '^[[1~' beginning-of-line     # Home
bindkey '^[[4~' end-of-line           # End

## Enable forward searching for history with ^S
## check key-assignment with `stty -a`, and verify ^S is assigned to stop
stty stop undef


# Hook functions
## On cd and pushd commands
function chpwd() {
    emulate -L zsh  # reset options that have been set by users
    ls -A
}


# --------------------------------------------------
#  Completion System
#  [[ Reference: https://zsh.sourceforge.io/Doc/Release/Completion-System.html ]]
# --------------------------------------------------
autoload -Uz compinit
compinit

# Context string format is defined as:
#   ':completion:${function}:${completer}:${command}:${argument}:${tag}'
# where ${function} is typically blank but is set if completion is called
# from a named widget rather than through the normal completion system.

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[-_./]=* r:|=* l:|=*'

# Control Functions
zstyle ':completion:*' completer _complete _correct _approximate  # consider enabling _expand
zstyle ':completion:*:correct:::'     max-errors 3 numeric  # note: allow numeric argument,
zstyle ':completion:*:approximate:::' max-errors 3 numeric  #       ESC ${n} TAB, to override

# Enable coloring which tries to match `ls` coloring
if type dircolors 1>/dev/null 2>&1; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors "${(@s.:.)LS_COLORS}"
else  # for non-GNU environment
    export CLICOLOR=1  # enable ls coloring (eqv. `ls -G` in macOS?)
    zstyle ':completion:*:default' list-colors ''
fi

# Set prompts shown on long completions
zstyle ':completion:*:default' list-prompt   '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:default' select-prompt '%SScrolling active: current selection at %p%s'

# Set message format and colors
zstyle ':completion:*:corrections'  format '%B%F{yellow}%d%f %F{red}(errors: %e)%f%b'
zstyle ':completion:*:descriptions' format '%B%F{yellow}completing %d%f%b'
zstyle ':completion:*:messages'     format '%B%F{yellow}%d%f%b'
zstyle ':completion:*:warnings'     format '%B%F{red}no matches for:%f %F{yellow}%d%f%b'

# Customize for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=1;32'
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,pcpu,tty,cputime,args'


# --------------------------------------------------
#  Load functions supplied by the distribution
#  [[ Reference: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html ]]
# --------------------------------------------------
# Load common functions
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

# Use pre-defined prompt format and colors --- promptinit {{{
autoload -Uz promptinit
promptinit

# Apply adam1 theme: see below for more on `prompt` command and adam1
#  % prompt
#  % prompt -h adam1
prompt adam1 blue cyan green
# }}}

# Customize prompt line for version control system --- vcs_info {{{
autoload -Uz vcs_info

# Export three messages shown below
# - $vcs_info_msg_0_, for normal messages (green)
# - $vcs_info_msg_1_, for warning messages (yellow)
# - $vcs_info_msg_2_, for error messages (red)

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git svn hg bzr

# Set common formats for vcs(s) other than git
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
    # Register hooks called when vcs (i.e. git) is detected.
    zstyle ':vcs_info:git+pre-get-data:*' hooks git-get-remote-info
    # Register hooks called each time before a `vcs_info_msg_N_` message is set.
    # It takes two arguments;
    # 1. the `N` in the message variable name,
    # 2. the currently configured formats or actionformats.
    # Note:
    #   each hook function is called on every message on either formats or actionformats
    #   in other words, at most they are called three times since actionformats takes three messages
    zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked git-ahead-behind git-stash-count

    function +vi-git-get-remote-info()
    {
        typeset -gA vcs_info_git_cache
        local repo_root="$(command git rev-parse --show-toplevel 2>/dev/null)"
        if [[ -z "${vcs_info_git_cache["$repo_root"]}" ]]; then
            local remotes=("${(@f)$(command git remote 2>/dev/null)}")
            local remotes_matching_origin=("${(@M)remotes:#origin}")
            local remote=''
            local default_branch=''
            if [[ "${#remotes_matching_origin[@]}" -gt 0 ]]; then
                remote='origin'
            elif [[ -n "${remotes[1]}" ]]; then
                remote="${remotes[1]}"
            fi
            if [[ -n "$remote" ]]; then
                # # default branch could be obtained by two-liners below but it is slow because
                # # `git remote show` makes an actual request to the remote. instead we use
                # # `git symbolic-ref` to find the branch HEAD on the remote points to. the
                # # information might be outdated but changing the default branch on the remote does
                # # not happen so frequently that it is okay in most cases.
                # local remote_info="$(command git remote show "$remote" 2>/dev/null)"
                # default_branch="${${remote_info/(#b)*HEAD branch*:[[:blank:]]#([[:graph:]]##)*/$match[1]}:#$remote_info}"
                for _ in {0..1}; do
                    local ref_remote_head="$(command git symbolic-ref refs/remotes/$remote/HEAD 2>/dev/null)"
                    if [[ $? -ne 0 ]]; then
                        command git remote set-head "$remote" --auto 2>/dev/null 1>&2
                        continue
                    fi
                    default_branch=${ref_remote_head##refs/remotes/$remote/}
                    break
                done
            else
                local branches=("${(@f)$(command git rev-parse --symbolic --branches 2>/dev/null)}")
                local candidates=("${(@M)branches:#(main|master)}")
                if [[ "${#candidates[@]}" -gt 0 ]]; then
                    default_branch="${candidates[1]}"
                fi
            fi
            local null=$'\0'
            vcs_info_git_cache["$repo_root"]="$remote$null$default_branch"
        fi
        pair=("${(@0)vcs_info_git_cache["$repo_root"]}")
        if [[ "${#pair[@]}" -eq 2 ]]; then
            user_data[remote]="$pair[1]"
            user_data[default_branch]="$pair[2]"
            return 0
        fi
    }

    # first hook function whose behavior is to determine
    #   1. if it is inside a working tree
    #   2. if it is for the second message (e.g. $vcs_info_msg_1_)
    #      as the following functions are for the second message (`%u` and `%m`)
    function +vi-git-hook-begin()
    {
        if [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) != 'true' ]]; then
            return 1  # prevent following hook functions from being called
        elif [[ "$1" -ne 1 ]]; then
            return 1  # prevent following hook functions from being called
        else
            return 0  # proceed following hook functions
        fi
    }

    # hook function for untracked files
    # which additionally prints '?' if there is an untracked file
    function +vi-git-untracked()
    {
        local status_info=("${(@f)$(command git status --porcelain 2>/dev/null)}")
        local unstaged_files=("${(@M)status_info:#*[?][?]*}")  # filter { it.contains("??") }
        if [[ "${#unstaged_files[@]}" -gt 0 ]]; then
            hook_com[unstaged]+='?'
        fi
    }

    # hook function for commits ahead or behind of the base branch (defined below)
    # which additionally prints
    #   - '(p<B|A)' when the branch has the remote-tracking branch
    #   - '(m<B|A)' when the branch does not have the remote-tracking branch
    # where A and B are the number of commits ahead or behind (respectively) of
    #   - (for (pX)) the remote-tracking branch
    #   - (for (mX)) the default branch configured by the remote (see `git remote show origin` for example)
    function +vi-git-ahead-behind()
    {
        local prefix='p'  # push
        local base_branch="$(command git rev-parse --abbrev-ref --symbolic-full-name @{upstream} 2>/dev/null)"
        if [[ -z "$base_branch" ]]; then
            prefix='m'  # merge
            base_branch=${user_data[default_branch]}
        fi
        # skip if the base branch (to be compared) cannot be determined or is the current branch itself
        [[ -z "$base_branch" || "$base_branch" = "${hook_com[branch]}" ]] && return 0

        local raw="$(command git rev-list --left-right --count "${base_branch}...${hook_com[branch]}" 2>/dev/null)"
        local pair=("${(@s: :)${raw//[[:space:]]/ }}")
        if [[ "${#pair[@]}" -eq 2 ]]; then
            local behind="${pair[1]}"
            local ahead="${pair[2]}"
            local status_expr="${status_expr}<${behind}|${ahead}"
            hook_com[misc]+="(${prefix}${status_expr})"
        fi
    }

    # hook function for stash
    # which additionally prints ':SN' where N is the number of stash entries
    function +vi-git-stash-count()
    {
        local raw="$(command git stash list 2>/dev/null)"
        if [[ -n "$raw" ]]; then
            local stashes=("${(@f)raw}")
            hook_com[misc]+=":S${#stashes[@]}"
        fi
    }
fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
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
# }}}


# ==================================================
#  Plugins installed by zplug
# ==================================================
if [[ ! -d "$HOME/.zplug" ]]; then
    git clone --filter=blob:none https://github.com/zplug/zplug "$HOME/.zplug"
fi
source "$HOME/.zplug/init.zsh"

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
