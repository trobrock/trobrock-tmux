#!/bin/zsh

free="$(df -h | grep '/$' | awk '{ print $5 }' | tr -d ' ' | tr -d '%')"

color="default"
if [ "$free" -ge 90 ]; then
  color="red"
elif [ "$free" -ge 75 ]; then
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
