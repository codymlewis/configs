#!/bin/sh


scrot -e 'mv $f ~/Pictures' && notify-send "Screenshot taken"
