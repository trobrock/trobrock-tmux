#!/bin/zsh

percent=$(vm_stat | awk -f $HOME/.tmux/scripts/memory.awk)

color="default"
if [ "$percent" -gt 90 ]; then
  color="red"
elif [ "$percent" -gt 75 ]; then
  color="yellow"
fi

output=""
if [[ $color == "default" ]]; then
  output="#[default]"
else
  output="#[fg=$color]"
fi

output="$output$percent%#[default]"
echo $output
