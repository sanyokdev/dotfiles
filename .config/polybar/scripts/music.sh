#!/bin/bash

player="--player=spotify"
status="$(playerctl status $player 2>&1)"
max_length=33
icon_on="%{T4}󰝚%{T-}"
icon_off="%{T4}󰝛%{T-}"

if [ "$status" != "No players found" ]; then
    raw_title=$(playerctl metadata --format "[{{ artist }}] {{ title }}" $player)
    duration=$(playerctl metadata --format "{{ duration(position) }}/{{ duration(mpris:length) }}" $player)

    if [ ${#raw_title} -gt $max_length ]; then
        title="${raw_title:0:$max_length - 3}..."
    else
        title="$raw_title"
    fi

    if [ "$status" == "Playing" ]; then
        echo "$icon_on Playing: $title ($duration)"
    elif [ "$status" == "Paused" ]; then
        echo "$icon_off Music Paused"
    else
        echo "$icon_off No Music Currently Playing"
    fi
else
    echo "$icon_off No Music Currently Playing"
fi
