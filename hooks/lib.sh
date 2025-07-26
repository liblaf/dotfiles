#!/bin/bash

function template() {
  "$CHEZMOI_EXECUTABLE" execute-template "$@"
}
