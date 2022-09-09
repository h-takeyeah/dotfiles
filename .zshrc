# ============
# youtaku .zshrc
#
# - Zinit
#   https://github.com/zdharma-continuum/zinit
#   - Powerlevel10k (Make sure Meslo Nerd Font is installed as system font!)
#     https://github.com/romkatv/powerlevel10k/blob/main/README.md
# - Settings from .bashrc
# - Settings from (bare) .zshrc
# ============

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Fix Delete key bug(Attention!! This keycode is for US keyboard)
bindkey "^[[3~" delete-char

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

### Settings from .bashrc
# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
### End of .bashrc chunk

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Start loading plugins (using zinit)
# Script that should be run after compinit call (compinit defines compdef inside it).
function after_completion_setup() {
  # bash compatible completion (for pipx etc...)
  autoload -Uz bashcompinit && bashcompinit
  eval "$(register-python-argcomplete pipx)"
}

# Load plugins in Turbo mode (wait) with no messages (lucid)
zinit wait lucid light-mode for \
    atinit'zicompinit; zicdreplay; after_completion_setup' \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start; zstyle ':completion:*:default' menu select=2" \
        zsh-users/zsh-autosuggestions

# Load powerlevel10k theme
zinit ice depth'1' # git clone depth
zinit light romkatv/powerlevel10k
### End of plugin installation chunk

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# gsamokovarov/jump
eval "$(jump shell)"

# volta-cli/volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pyenv integration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
