# Set target directory to be XDG_CONFIG_DIR by default, otherwise ~/.config
target = $(XDG_CONFIG_DIR)
ifeq ($(strip $(target)),)
	target = ~/.config
endif

# Flags to use for operation
flags = -n

link:
	stow $(flags) -t $(target) .

unlink:
	stow -D $(flags) -t $(target) .

test: link
	flags := ${flags}v

install: link
	flags := ${flags}S

clean:
	flags := ${flags}D
