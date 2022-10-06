#!/usr/bin/env sh
# on click

# toggle default sink
num_of_sinks=$(pactl list sinks short | wc -l)
current_default=$(pacmd list-sinks | grep '* index' | awk '{print $3}')
next_default=$(echo "($current_default + 1) % $num_of_sinks" | bc)
pactl set-default-sink $next_default

# move active sink-inputs to new sink
pactl list sink-inputs short | awk '{print $1}' | while read input_id; do
  pactl move-sink-input $input_id @DEFAULT_SINK@
done
