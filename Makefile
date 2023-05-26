MAKEFLAGS += --jobs

all:

clean:
	git clean -d --force -X

update:
	git submodule update --init --recursive
	git submodule foreach git pull
