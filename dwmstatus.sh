#!/bin/sh

get_volume() {
    vol=$(amixer get Master | awk -F'[][]' 'END{ print $2 }' | sed 's/%//g')
    is_muted=$(amixer get Master | grep 'off')
    if [ "$is_muted" ]; then
        echo " "
    else
        if [ "$vol" -gt 50 ]; then
            vol=" $vol"
        elif [ "$vol" -gt 0 ]; then
            vol=" $vol"
        else
            vol=" $vol"
        fi
        printf "%s" "$vol%"
    fi
}

get_brightness() {
    xbacklight | cut -c -6
}

get_battery() {
    cap=$(cat /sys/class/power_supply/BAT0/capacity)
    if grep 'Discharging' /sys/class/power_supply/BAT0/status > /dev/null; then
        if [ "$cap" -lt 20 ]; then
            baticon=""
        elif [ "$cap" -lt  40 ]; then
            baticon=""
        elif [ "$cap" -lt 60 ]; then
            baticon=""
        elif [ "$cap" -lt 80 ]; then
            baticon=""
        else
            baticon=""
        fi
    else
        baticon=""
    fi
    echo "$baticon $cap"
}

while true; do
    xsetroot -name "$(echo \ $(nmcli | head -n 1)\ \  $(get_brightness)%\ \ $(get_volume)\ \ $(get_battery)%\ \  $(date '+%F %T')\ \ )"
    sleep 1
done
