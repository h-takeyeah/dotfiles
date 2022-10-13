# dotfiles

My dotfiles

## config

### sway
Open `/usr/share/wayland-sessions/sway.desktop` and replace `Exec=sway` with `Exec=/usr/local/bin/sway-run`. Create symlink `/usr/local/bin/sway-run` which references [`sway-run.sh`](./local/bin/sway-run.sh)
