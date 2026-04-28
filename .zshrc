export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

ZSH_DISABLE_COMPFIX="true" 

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_THEME="robbyrussell"

export ZSH="$HOME/.config/.oh-my-zsh"

plugins=(
  git
)

source "$ZSH/oh-my-zsh.sh"

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

source "$HOME/.config/.aliases"
source "$HOME/.config/.path"
source "$HOME/.config/.exports"

export GPG_TTY=$(tty)

eval "$(zoxide init zsh)"

eval "$(keychain --dir ~/.config/keychain --eval --quiet)"
