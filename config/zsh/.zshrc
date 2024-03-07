ZSHRC_DIR=${${(%):-%N}:A:h}

export PATH="$PATH:$HOME/.local/bin"

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

autoload -Uz compinit; compinit
zstyle ':completion:*:default' menu select=2

export SHELDON_CONFIG_DIR="$ZSHRC_DIR/sheldon"
export SPACESHIP_CONFIG_PATH=("$ZSHRC_DIR/spaceship/spaceship.zsh" $SPACESHIP_CONFIG_PATH)

# load plugins
eval "$(sheldon source)"

export PATH="$PATH:/usr/local/go/bin"

eval "$(direnv hook zsh)"

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --corepack-enabled)"

[ -f "$ZSHRC_DIR/.zsh_aliases" ] && source "$ZSHRC_DIR/.zsh_aliases"

# podman
podman system connection add podman -d --identity ~/.ssh/id_ed25519 ssh://user@$(hostname -I|tr -d " "):58596/run/user/1000/podman/podman.sock

# rust
. "$HOME/.cargo/env"

# bun completions
[ -s "/home/youtaku/.bun/_bun" ] && source "/home/youtaku/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# deno
export DENO_INSTALL="/home/youtaku/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# jump
eval "$(jump shell)"

# golang
export PATH="$PATH:/usr/local/go/bin"

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
