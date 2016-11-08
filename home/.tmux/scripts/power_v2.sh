#!/bin/bash

is_osx() {
  [ $(uname) == "Darwin" ]
}

command_exists() {
  local command="$1"
  type "$command" >/dev/null 2>&1
}

battery_status() {
  if command_exists "pmset"; then
    pmset -g batt | awk -F '; *' 'NR==2 { print $2 }'
  elif command_exists "upower"; then
    # sort order: attached, charging, discharging
    for battery in $(upower -e | grep battery); do
      upower -i $battery | grep state | awk '{print $2}'
    done | sort | head -1
  elif command_exists "acpi"; then
    acpi -b | grep -oi 'discharging' | awk '{print tolower($0)}'
  fi
}

battery_percentage() {
  # percentage displayed in the 2nd field of the 2nd row
  if command_exists "pmset"; then
    pmset -g batt | awk 'NR==2 { gsub(/;/,""); print $3 }'
  elif command_exists "upower"; then
    for battery in $(upower -e | grep battery); do
      upower -i $battery | grep percentage | awk '{print $2}'
    done | xargs echo
  elif command_exists "acpi"; then
    acpi -b | grep -Eo "[0-9]+%"
  fi
}

power=$(echo $(battery_percentage))
power_int=$(echo $power | sed 's/%//')

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

if [ $(battery_status) = "charging" ]
then
  output="#[default]⟲ $output"
fi

echo "$output$power"
