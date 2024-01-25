#!/bin/bash

if grep --ignore-case intel /proc/cpuinfo > /dev/null; then
  export INTEL=true
fi
