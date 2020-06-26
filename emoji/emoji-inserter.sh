#!/bin/bash

EMOJI=$(cat "$HOME/.config/emoji/emoji-list.txt" |
        dmenu -i -p "Which emoji would you like" |
        awk '{print $1}')
! [[ $EMOJI = "" ]] &&
        (printf  "%s" "$EMOJI" | xsel) &&
        notify-send "$EMOJI placed in the clipboard"
