#!/bin/bash

function docker() {
  newgrp docker -c "docker $*"
}
