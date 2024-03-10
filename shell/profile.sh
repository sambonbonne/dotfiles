#
# ~/.profile
# Eventually sourced by the shell
#

# disable XON/XOFF
stty -ixon

SH_CONFIG_PATH="${HOME}/.config/profile"
load_sh_config() {
  . "${SH_CONFIG_PATH}/${1}.sh"
}

load_sh_config "env"
load_sh_config "path"
load_sh_config "ssh_agent"
load_sh_config "lc"
load_sh_config "tools"
load_sh_config "aliases"
load_sh_config "completion"

# sometimes the TERM variable is not really pretty
if [ "${TERM}" = xterm ] || [ "${TERM}" = vt220 ]; then
    export TERM="xterm-256color"
fi
