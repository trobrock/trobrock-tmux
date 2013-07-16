#!/bin/zsh

echo $(uptime | awk -F'load averages:' '{ print $2 }' | awk '{ print $2 }')
