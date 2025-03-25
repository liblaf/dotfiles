default: gen update-config

gen: gen-starship

gen-starship:
  python "gen/starship/main.py"

update-config:
  chezmoi init --source "."
