#!/bin/bash

echo "$(ps -ef | grep [V]BoxHeadless | wc -l | tr -d ' ')"
