#!/usr/bin/env zsh

zmodload zsh/complist
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate _prefix
zstyle ':completion:*' menu select=2

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

[[ -n "${key[Up]}"    ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}"  ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

export PROMPT="%F{green}%n%f%F{yellow}@%f%B%F{blue}%m%b%f %F{magenta}%~%f %F{red}%#%f "

bindkey -e

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
bindkey -s "^V" 'pulsemixer\n'
bindkey -s "^Z" 'fzfmpc\n'

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

wd () {
        config="$HOME/.config/zsh/warprc"
        case $1 in
                "list")
                       sed 's/ / -> /' "$config"
                ;;
                "add")
                       printf "%s %s\n" "$2" "$PWD" >> "$config"
                ;;
                "rm")
                       temp=$(grep -v "$2"\\s "$config")
                       echo "$temp" > "$config"
                ;;
                *)
                       wp=$(grep -m1 "$1[[:space:]]" "$config" | awk '{ print $2 }')
                       cd "$wp" || \
                              (echo "Could not warp to point $1" && exit)
                ;;
        esac
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
