#!/usr/bin/env sh
# on click

# toggle default sink
sinks=($(pactl list sinks short | awk '{print $1}'))
num_of_sink=${#sinks[@]}
current_sink=$(pacmd list-sinks | grep '* index' | awk '{print $3}')
next_sink_index=0

for i in "${!sinks[@]}"
do
  if [ "${sinks[$i]}" = "$current_sink" ]
  then
    next_sink_index=$(echo "($i + 1) % $num_of_sink" | bc)
    break
  else
    :
  fi
done
pactl set-default-sink ${sinks[$next_sink_index]}
