#!/bin/bash

if docker version > /dev/null 2>&1 ; then
  count="$(docker ps --format '{{.ID}}' | wc -l | tr -d ' ')"
  if [ "$count" -gt 0 ]; then
    output="#[fg=yellow]"
  else
    output="#[default]"
  fi
  output="$output$count"
else
  output="#[fg=yellow]OFF"
fi

output="$output#[default]"
echo $output
