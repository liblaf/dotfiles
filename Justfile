default: gen update-config

gen: gen-starship gen-port

gen-starship:
  python "gen/starship/main.py"

gen-port:
  python "gen/port.py"

update-config:
  chezmoi init --source "."
