ZSHRC_DIR=${${(%):-%N}:A:h}

export PATH="$PATH:$HOME/.local/bin"

bindkey -e
# delete key as delete-char(for US keyboard)
bindkey "^[[3~" delete-char

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

autoload -Uz compinit; compinit
zstyle ':completion:*:default' menu select=2

export SHELDON_CONFIG_DIR="$ZSHRC_DIR/sheldon"
export SPACESHIP_CONFIG_PATH=("$ZSHRC_DIR/spaceship/spaceship.zsh" $SPACESHIP_CONFIG_PATH)

# load plugins
eval "$(sheldon source)"

[ -f "$ZSHRC_DIR/.zsh_aliases" ] && source "$ZSHRC_DIR/.zsh_aliases"

# go
export PATH="$PATH:/usr/local/go/bin:${GOPATH:-$HOME/go}/bin"

# rust
#. "$HOME/.cargo/env"

# bun completions
[ -s "/home/youtaku/.bun/_bun" ] && source "/home/youtaku/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# deno
export DENO_INSTALL="/home/youtaku/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# zig
export PATH="$HOME/zig:$PATH"

# jump
eval "$(jump shell)"

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
