#!/bin/sh

export XDG_CURRENT_DESKTOP=sway
export QT_QPA_PLATFORM="wayland;xcb"
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

exec sway
