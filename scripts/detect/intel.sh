#!/bin/bash

if grep GenuineIntel /proc/cpuinfo > /dev/null; then
  export INTEL=true
fi
