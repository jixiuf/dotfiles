#!/bin/zsh
TEMP=$( getopt --options h --longoptions session:,cwd:,help -- "$@" ) || exit 1
eval set -- "$TEMP"
echo $@>/tmp/f
session_1=""
session_2=""
cwd="$PWD"

for i in "$@"; do
    case "$i" in
        -h|--help)
            echo "Usage: $PROG -session sess_name -cwd cwd other args"
            exit 0
            ;;
        --session*)
            session_1="-t$2"
            session_2="-s$2"
            shift
            shift
            ;;
        --cwd*)
            cwd="$2"
            shift
            shift
            ;;
    esac
done

shift
echo "tmux attach  $session_1 -c $cwd||tmux new-session $session_2 $@" >/tmp/e
tmux attach  $session_1 -c $cwd||tmux new-session $session_2 $@
