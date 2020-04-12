#!/usr/bin/env zsh

source "$ZDOTDIR/antigen.zsh"

antigen use oh-my-zsh

antigen bundle wd
antigen bundle sudo

antigen theme norm

antigen apply

alias wd="wd --config ~/.config/zsh/warprc"

alias ls="ls -hN --color=auto --group-directories-first"
alias sl="ls"
alias ll="ls -l"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -l -a"
alias lal="ls -l -a"
alias SS="sudo systemctl"
alias ccat="highlight --out-format=ansi --force"
alias grep="grep --color"
alias p="sudo pacman"
alias k="kak"
alias v="nvim"
alias vs="nvim -S"
alias vt="nvim -t"
alias e="emacsclient -nw"
alias z="zathura"
alias g="git"
alias x='exit'
alias :q='exit'
alias ..='cd ../'
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias tmuxcon='tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n"$USER" -s"$USER"@"$HOSTNAME"'
bindkey -s '^N' 'ncmpcpp\n'
bindkey -s '^P' 'f=$(fzf) && open "$f"\n'

open () {
        for a in $@; do
                ([[ "$a" =~ .*.[(pdf)(djvu)]$ ]] && zathura "$a") ||
                        ([[ "$a" =~ .*.[(png)(jpe?g)]$ ]] && sxiv "$a") ||
                        ([[ "$a" =~ .*.[(mp4)(mkv)(mp3)(ogg)(wav)(webm)]$ ]] && mpv "$a") ||
                        nvim "$a"
        done
}

alias yd="youtube-dl -ic --add-metadata -f 'bestvideo+bestaudio/best'" # Download video link
alias yda="youtube-dl -x -f bestaudio/best" # Download only audio

ydall () {
        olddir=$(pwd)
        cd $HOME/Videos
        youtube-dl $@ -ic --add-metadata -f 'bestvideo+bestaudio/best' 'https://www.youtube.com/playlist?list=PLtrReXASdY_GciC24eqggMeQ0xgHsTZKY'
        cd "$olddir"
}

gdoc () {
        refer -PS -e -p "$HOME/Groff/bibliography" "$1.ms" | \
                groff -ms -e -m "$HOME/Groff/macros" -T pdf > "$1.pdf"
                        pgrep -a zathura | grep "$1.pdf" > /dev/null 2>&1 || zathura "$1.pdf" $@ &
}

alias sxiv="sxiv -a"
alias ct="uctags"

m () {
        find "$2" 1>/dev/null || mkdir -p "$2"
        sudo mount "$1" "$2" && echo "Successfully mounted $1 at $2"
}

u () {
        sudo umount "$1" && sync && echo "$1 was successfully unmounted"
}

b () {
        find "$HOME/mnt/backup" 1>/dev/null || mkdir -p "$HOME/mnt/backup"
        m "$1" "$HOME/mnt/backup" && \
                bak_fol="$(date | sed 's/ /_/g')" && \
                mkdir "$HOME/mnt/backup/$bak_fol" && \
                echo "Backing up files..." && \
                cp -r "$HOME/Desktop" "$HOME/Music" "$HOME/suckless" "$HOME/mnt/backup/$bak_fol" && echo "Done Backup" && \
                u "$HOME/mnt/backup"
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
