#! /usr/bin/env bash
# original idea:
# https://www.reddit.com/r/swaywm/comments/bxsp97/swaywm_hotplug_external_displaysmonitors_udev/

SWAY_SOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
if [ $(/usr/bin/swaymsg --socket $SWAY_SOCK --type get_outputs --raw | /usr/bin/jq '.[] | select(.name=="eDP-1").active') = 'false' ]; then
  # swaymsg doesn't return non-zero when output name is invalid(means
  # "swaymsg output NONEXISTING_MONITOR enable" will exit 0).
  # It returns 1 or 2 only when command syntax error or transport error.
  # So, you may miss an error and be carefull.
  /usr/bin/swaymsg --socket $SWAY_SOCK --quiet output eDP-1 enable
fi

exit $?
