#!/bin/bash

get_ip() {
    ip -4 address show "$1" | grep inet | awk '{print $2}'
}

get_mem() {
    mem="$(free -h | grep Mem)"
    free="$(echo "$mem" | awk '{print $3}')"
    total="$(echo "$mem" | awk '{print $2}')"
    printf "%s/%s" "$free" "$total"
}

get_swap() {
    mem="$(free -h | grep Swap)"
    free="$(echo "$mem" | awk '{print $3}')"
    total="$(echo "$mem" | awk '{print $2}')"
    printf "%s/%s" "$free" "$total"
}

music_status() {
    if mpc status | grep "playing" > /dev/null; then
        echo ""
    else
        echo ""
    fi
}

cpu_usage() {
    usage=$(top -b -n 1 | grep Cpu | awk '{print $2}')
    printf "%5.1f" "$usage"
}

echo " $(music_status) $(mpc current)    $(get_ip wlo1)   $(get_mem)   $(cpu_usage)%  "
