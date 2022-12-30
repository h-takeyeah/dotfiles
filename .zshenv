. "$HOME/.cargo/env"
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
typeset -U path PATH
path=($HOME/.local/bin $HOME/go/bin $HOME/.deno/bin $HOME/.volta/bin $HOME/flutter/bin $path)
export PATH
export CHROME_EXECUTABLE=google-chrome-stable # for flutter
