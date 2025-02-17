#!/bin/bash

if grep --ignore-case intel /proc/cpuinfo > /dev/null; then
  echo "Hardware > Intel CPU: true"
  export INTEL=true
fi
