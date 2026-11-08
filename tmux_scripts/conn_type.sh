#!/bin/sh
# Print S (ssh), M (mosh) or T (local tty) for the tmux client PID given as $1,
# by walking up its process ancestry.
pid=$1
while [ -n "$pid" ] && [ "$pid" -gt 1 ] 2>/dev/null; do
    comm=$(ps -o comm= -p "$pid" 2>/dev/null)
    case $comm in
        mosh-server*) printf M; exit ;;
        sshd*)        printf S; exit ;;
    esac
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
done
printf T
