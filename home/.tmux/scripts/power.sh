#!/bin/zsh
power=$(/usr/sbin/ioreg -l | awk 'BEGIN{a=0;b=0}
  $0 ~ "MaxCapacity" {a=$5;next}
  $0 ~ "CurrentCapacity" {b=$5;nextfile}
  END{printf("%.2f%%", b/a * 100)}')

charging=$(/usr/sbin/ioreg -l | awk '/IsCharging/{ print $5 }')

power_int=$(echo $power | sed 's/\..*//')

output=""
if [ $power_int -gt 75 ]
then
  output="$output#[default]"
elif [ $power_int -lt 20 ]
then
  output="$output#[fg=red]"
else
  output="$output#[fg=yellow]"
fi

if [ $charging = "Yes" ]
then
  output="#[default]⟲ $output"
fi

echo "$output$power"
