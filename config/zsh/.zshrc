#!/usr/bin/env zsh
#source $ZDOTDIR/config.zsh

# NOTE ZGEN_DIR and ZGEN_SOURCE are forward-declared in modules/shell/zsh.nix
# NOTE Using zgenom because zgen is no longer maintained
if [ ! -d "$ZGEN_DIR" ]; then
  echo "Installing jandamm/zgenom"
  git clone https://github.com/jandamm/zgenom "$ZGEN_DIR"
fi
source $ZGEN_DIR/zgenom.zsh

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

if ! zgenom saved; then
  echo "Initializing zgenom"
  rm -f $ZDOTDIR/*.zwc(N) \
        $XDG_CACHE_HOME/zsh/*(N) \
        $ZGEN_INIT.zwc

  # NOTE Be extra careful about plugin load order, or subtle breakage can
  #   emerge. This is the best order I've sussed out for these plugins.
  zgenom load jeffreytse/zsh-vi-mode
  zgenom load zdharma-continuum/fast-syntax-highlighting
  zgenom load zsh-users/zsh-completions src
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load hlissner/zsh-autopair autopair.zsh

  zgenom save
  zgenom compile $ZDOTDIR
fi



# Aliases
alias c='clear'
alias n='nvim -u ~/.config/nvim/init.lua' #hacky fix, I know
alias e='exit'
alias g='git'

alias ls='exa --icons --group-directories-first'
alias tree='exa --tree --icons'
alias sl='ls'

alias cat='bat --style=plain'
alias grep='rg'

alias cleanup='sudo nix-collect-garbage --delete-older-than 7d'
alias rebuild='sudo nix-store --verify; sudo nixos-rebuild switch --flake .#'
alias need='nix-shell -p'

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gs='git status'


alias ssh='kitty +kitten ssh'
