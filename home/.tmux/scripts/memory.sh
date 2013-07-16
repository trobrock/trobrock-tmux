#!/bin/zsh

memory=$(vm_stat | grep 'Pages')
free=$(echo $memory | awk '/Pages free/{ print $3 }' | tr -d '.')
active=$(echo $memory | awk '/Pages active/{ print $3 }' | tr -d '.')
inactive=$(echo $memory | awk '/Pages inactive/{ print $3 }' | tr -d '.')
speculative=$(echo $memory | awk '/Pages speculative/{ print $3 }' | tr -d '.')
wired=$(echo $memory | awk '/Pages wired/{ print $4 }' | tr -d '.')

percent=$(perl -e "use Math::Round ; print round(($active + $inactive + $speculative + $wired) / ($active + $inactive + $speculative + $wired + $free) * 100)")

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
