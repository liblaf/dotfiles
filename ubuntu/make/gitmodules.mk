.PHONY: gitmodules
gitmodules:
	@ call git submodule update --init --remote --depth 1 --recursive
