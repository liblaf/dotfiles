SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name '*.sh' -type f)
SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name '*.sh.tmpl' -type f)
SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name '*.zsh' -type f)
SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name '*.zsh.tmpl' -type f)
SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name 'dot_zshrc' -type f)
SHELL_SCRIPT_LIST += $(shell find $(CURDIR) -name 'dot_zshrc.tmpl' -type f)

all:

pretty: $(SHELL_SCRIPT_LIST)
	shfmt --write --simplify --indent 2 --case-indent --space-redirects $(SHELL_SCRIPT_LIST)
