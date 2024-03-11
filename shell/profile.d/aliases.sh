# general and command aliases
alias search='grep -RnF --color=always'
alias c='clear && l'
alias ee='exit'
alias monochrome='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"' # pipe anything here
alias ports='ss -atn' # list opened ports
alias clean_editors_tmp_files='find . -type f -name "*~" -exec rm -f {} \;'
alias quickpod='podman run --rm -it -v "$(pwd):/mnt:z" -w /mnt'
alias ssh-specific='ssh -oIdentitiesOnly=yes -oStrictHostKeyChecking=no'

# custom ls/exa wrapper
command -v exa 2>&1 >/dev/null \
  && alias l='command exa -Fl --group-directories-first --time-style="long-iso" --git' \
  || alias l='ls -Fhl --group-directories-first --color=always'

# Encrypting
alias cipher='openssl rsautl -encrypt -pubin -inkey'
alias decipher='openssl rsautl -decrypt -inkey'

# utilities
alias util_ssh_force='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias util_docker_images_rm_anonymous='docker rmi $(docker images | grep "^<none>" | tr -s " " | cut -d " " -f 3)'
alias util_syncthing_list_conflicts="find ./ -type f -name '*.sync-conflict*'"
alias util_vim_clean_swap='find ./ -type f -name "\.*sw[klmnop]" -delete'
alias util_steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'

command -v thefuck >/dev/null && eval "$(thefuck --alias)"

alias g='git'

alias k='kubectl'
alias kk='echo "$(kubectl config current-context) / $(kubectl config view --minify | grep namespace | cut -d" " -f6 | tr -d "\n")"'
alias kx="_KUBECTX_FORCE_COLOR=1 kubectx | SEARCH_PROMPT='Kube context' seaunch kubectx"
alias kn="_KUBECTX_FORCE_COLOR=1 kubens | SEARCH_PROMPT='Kube namespace' seaunch kubens"
