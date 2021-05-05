# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#                       __ _ _
#      _ __  _ __ ___  / _(_) | ___
#     | '_ \| '__/ _ \| |_| | |/ _ \
#    _| |_) | | | (_) |  _| | |  __/
#   (_) .__/|_|  \___/|_| |_|_|\___|
#     |_|
#
# _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


# Locale
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8


# Variables used by external commands
if type vim &>/dev/null; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi
if type lv &>/dev/null; then
    export PAGER='lv -c'
else
    export PAGER='less'
fi

# PATH for m4 as a part of circuit_macros
if [ -d /opt/circuit_macros ]; then
    export M4PATH=/opt/circuit_macros
fi

# PATH
LOCALBINPATH=("$HOME/bin" "$HOME/.local/bin" "$HOME/.cabal/bin")
case "$(uname -s 2> /dev/null)" in
    Darwin*)
        GNUBINPATH=(
            "/usr/local/opt/coreutils/libexec/gnubin"
            "/usr/local/opt/findutils/libexec/gnubin"
            "/usr/local/opt/gnu-getopt/bin"
            "/usr/local/opt/gnu-indent/libexec/gnubin"
            "/usr/local/opt/gnu-sed/libexec/gnubin"
            "/usr/local/opt/gnu-tar/libexec/gnubin"
            "/usr/local/opt/gnu-which/libexec/gnubin"
            "/usr/local/opt/grep/libexec/gnubin"
        ) ;;
    *)  GNUBINPATH=() ;;
esac
for i in "${LOCALBINPATH[@]}" "${GNUBINPATH[@]}"; do
    # if $i is a directory and NOT contained in $PATH
    if [ -d $i ] && [ "${PATH##*$i*}" = "$PATH" ]; then
        export PATH="$i:$PATH"
    fi
done

# Envs for input methods
case "$(uname -s 2> /dev/null)" in
    Linux*|GNU*)
        if type fcitx &>/dev/null || type fcitx5 &>/dev/null; then
            imfw=fcitx
        elif type ibus &>/dev/null; then
            imfw=ibus
        elif type scim &>/dev/null; then
            imfw=scim
        elif type uim-xim &>/dev/null; then
            imfw=uim
        fi
        if [ -n "$imfw" ]; then
            [ -z "$XMODIFIERS" ] && export XMODIFIERS=@im=$imfw
            for e in 'GTK_IM_MODULE' 'QT_IM_MODULE'; do
                [ -z "$(eval echo '$'$e)" ] && eval export $e=$imfw
            done
        fi ;;
esac
