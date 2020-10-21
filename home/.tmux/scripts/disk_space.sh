#!/bin/bash

free="$(df -h | awk '/\/System\/Volumes\/Data$/{ gsub(/%/, "", $5); print $5 }')"

color="default"
if [ "$free" -ge 95 ]; then
  color="red"
elif [ "$free" -ge 90 ]; then
  color="yellow"
fi

output=""
if [[ $color == "default" ]]; then
  output="#[default]"
else
  output="#[fg=$color]"
fi

output="$output$free%#[default]"
echo $output
