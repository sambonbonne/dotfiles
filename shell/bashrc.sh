# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source "${HOME}/.profile"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if command -v starship; then
	eval "$(starship init bash)"
else
	export PS1="\\u @ \\H \[\e[1m\]\\w\[\e[0m\] ❯ "
	echo "Starship is not installed, basic prompt set."
fi
