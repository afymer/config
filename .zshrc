ZSH_DISABLE_COMPFIX="true" 

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
)

source "$ZSH/oh-my-zsh.sh"

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

function _load_ssh_agent() {
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null
    fi

    if ! ssh-add -l | grep -q "id_github_sign_and_auth"; then
        ssh-add ~/.ssh/id_github_sign_and_auth 2>/dev/null
    fi
}
_load_ssh_agent

source "$HOME/.config/.aliases"
source "$HOME/.config/.path"
source "$HOME/.config/.exports"

eval "$(zoxide init zsh)"

# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
eval $(keychain --eval --quiet id_ed25519)

export PATH="$HOME/.local/bin:$PATH"
