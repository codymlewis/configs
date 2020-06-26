#!/bin/sh

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"
export XDG_CONFIG_HOME="$HOME.config"
export XDG_USER_CONFIG_DIR="$XDG_CONFIG_HOME"
export PATH="$HOME.local/bin:$PATH"
export HISTFILE="$XDG_CONFIG_HOME"/zsh/history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_NDK_ROOT="$ANDROID_HOME/ndk/21.1.6352462/"
export ANDROIDAPI="26"
# export NDKAPI="21"

[ -d "$HOME.nvm" ] && export NVM_DIR="$HOME/.nvm" && \
       [ -s "$NVM_DIR/nvm.sh" ] && \. "NVM_DIR/nvm.sh"

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Add RVM to PATH for scripting.
[ -d "$HOME.rvm" ] && export PATH="$PATH:$HOME.rvm/bin"
[[ -s "$HOME.rvm/scripts/rvm" ]] && source "$HOME.rvm/scripts/rvm"

pgrep 'mpd' > /dev/null || mpd ~/.config/mpd/mpd.conf &
pgrep 'startx' > /dev/null || startx
