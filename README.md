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

# or just copy favorite image file to config/sway/wallpaper directory and rename them to wallpaper_{default,edp1}.
```

#### sway (optional)
- A shell script to turn on the internal LCD(in-LCD) when an external monitor is plugged in or unplugged.
```bash
ln -s /path/to/thisrepo/local/bin/onchange-monitor.sh ~/.local/bin/onchange-monitor.sh
echo -n "ACTION==\"change\", SUBSYSTEM==\"drm\", RUN+=\"/usr/bin/su $(id -un) -c ~/.local/bin/onchange-monitor.sh\"" | sudo tee /etc/udev/rules.d/95-extenal-monitor-onchange.rules
sudo udevadm control --reload
```

(How to check) Turn off in-LCD and run `journalctl -f -u systemd-udevd` to see logs. Then plug in/out HDMI cable and check the script had run by reading logs and in-LCD turned on. Something wrong? then run the command `journalctl...` to debug.

### swaylock
Make sure `lockscreen` exist
```bash
cd /path/to/thisrepo
ln -s /path/to/lockscreen_image.{png,jpg} config/swaylock/lockscreen

# or just copy favorite image file to config/swaylock directory.
```

### waybar

#### custom/media module
Make sure [`playerctl`](https://github.com/altdesktop/playerctl) is installed.

> For some website which cannot make pretty MPRIS output, you should install browser extension. For example *Apple Music* (music.apple.com) does not provide enough infomation.
>
> - For google chrome, I use [Plasma Integration](https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai). I'm not sure if KDE Plasma always need to be installed to make it work.
> - Firefox builtin MPRIS support looks good (I'm mainly using chrome).

### debug discord
Set `DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING` to `true` in `${XDG_CONFIG_HOME:-$HOME}/.config/discord/settings/json`

### zsh
```bash
ln -s /path/to/thisrepo/config/zsh/.zshrc ~/.zshrc
```
