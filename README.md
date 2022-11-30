# dotfiles

My dotfiles

## config

### sway
Open `/usr/share/wayland-sessions/sway.desktop` and replace `Exec=sway` with `Exec=/usr/local/bin/sway-run`. Create symlink `/usr/local/bin/sway-run` which references [`sway-run.sh`](./local/bin/sway-run.sh)

Make sure `wallpaper_default` and `wallpaper_edp1` exist
```bash
cd /path/to/thisrepo
ln -s /path/to/wallpaper.{png,jpg} config/sway/wallpapers/wallpaper_defualt
ln -s /path/to/wallpaper.{png,jpg} config/sway/wallpapers/wallpaper_edp1

# or just copy favorite image file to config/sway/wallpaper directory.
```

### swaylock
Make sure `lockscreen` exist
```bash
cd /path/to/thisrepo
ln -s /path/to/lockscreen_image.{png,jpg} config/swaylock/lockscreen

# or just copy favorite image file to config/swaylock directory.
```


### debug discord
Set `DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING` to `true` in `${XDG_CONFIG_HOME:-$HOME}/.config/discord/settings/json`
