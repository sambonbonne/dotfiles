# general and command aliases
alias search='grep -RnF --color=always'
alias c='clear && l'
alias ee='exit'
alias monochrome='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"' # pipe anything here
alias ports='ss -atn' # list opened ports
alias clean_editors_tmp_files='find . -type f -name "*~" -exec rm -f {} \;'
alias quickpod='podman run --rm -it -v "$(pwd):/mnt:z" -w /mnt'
alias vagrant_pod='podman run --rm -it \
  --volume /run/libvirt:/run/libvirt \
  --volume "${HOME}:${HOME}:rslave" \
  --env "HOME=${HOME}" \
  --workdir "$(pwd)" \
  --net host \
  --privileged \
  --security-opt label=disable \
  --entrypoint /usr/bin/vagrant \
  localhost/vagrant-container:latest'
alias ssh-specific='ssh -oIdentitiesOnly=yes -oStrictHostKeyChecking=no'

# custom ls/exa wrapper
list() {
  if ! command -v exa >/dev/null; then
    ls -Fhl --group-directories-first --color=always "$@"
  else
    exa -Fl --group-directories-first --time-style="long-iso" --git "$@"
    # if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    #   exa -Fl --group-directories-first --time-style="long-iso" --git "$@"
    # else
    #   exa -Fl --group-directories-first --time-style="long-iso" "$@"
    # fi
  fi
}
alias l='list'

# Encrypting
alias cipher='openssl rsautl -encrypt -pubin -inkey'
alias decipher='openssl rsautl -decrypt -inkey'

# utilities
alias util_ssh_force='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias util_docker_images_rm_anonymous='docker rmi $(docker images | grep "^<none>" | tr -s " " | cut -d " " -f 3)'
alias util_syncthing_list_conflicts="find ./ -type f -name '*.sync-conflict*'"
alias util_vim_clean_swap='find ./ -type f -name "\.*sw[klmnop]" -delete'
alias util_steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'

util_ssh_prepare() {
  infocmp | ssh "${1}" "tic -x /dev/stdin"
}

util_git_sub_sync() {
  find . -maxdepth 1 -type d | while read -r DIR; do
    if [ -d "${DIR}/.git" ]; then
      cd "${DIR}"

      MAIN_BRANCH="$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')"
      CURRENT_BRANCH="$(git branch --show-current)"

      if [ "${MAIN_BRANCH}" !=  "${CURRENT_BRANCH}" ]; then
        git checkout "${MAIN_BRANCH}"
      fi

      git pull --rebase

      if [ "${MAIN_BRANCH}" !=  "${CURRENT_BRANCH}" ]; then
        git checkout "${CURRENT_BRANCH}"
      fi

      cd -
    fi
  done
}

command -v thefuck >/dev/null && eval "$(thefuck --alias)"


# shrink a PDF
pdfshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}
# shrink even more a PDF
pdfXshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}

# find something and edit
quickedit() {
  quickedit_place_to_search="${2:-./}"
  quickedit_result="$(grep -m 1 --exclude "*~" --exclude-dir .git/ -rnF "${1}" "${quickedit_place_to_search}" | head -n 1 | cut -d: -f1,2)"

  test -z "${quickedit_result}" && echo "No match found for « ${1} »" && return 1

  quickedit_file="$(echo $quickedit_result | cut -d: -f1)"
  quickedit_line="$(echo $quickedit_result | cut -d: -f2)"

  ${EDITOR} "${quickedit_file}" "+${quickedit_line}"
}

# Python virtualenv facility
venv() {
  test "${VIRTUAL_ENV}" = "" && test "${1}" = "" && exit 0

  if [ "${VIRTUAL_ENV}" = "" ]; then
    VENV_SOURCE_PATH="$(pwd)/${1}/bin/activate"

    if [ ! -f "${VENV_SOURCE_PATH}" ]; then
      echo "${1} virtual env does not exist, create it? [y/n]"
      read -r VENV_CREATE

      test "${VENV_CREATE}" != "y" && exit 0
      python3 -m venv "${1}"
    fi

    . "${VENV_SOURCE_PATH}"
    rehash 2>/dev/null || true
  elif [ "${1}" = "update" ]; then
    python3 -m pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  else
    deactivate || unset VIRTUAL_ENV
    rehash
  fi
}

# Search and launch with Skim
seaunch() {
  if ! command -v skim >/dev/null; then
    echo "skim is not installed"
    return 1
  fi

  SEARCH_LIST=""

  while read -r SEARCH_LIST_ELEMENT; do
    SEARCH_LIST="${SEARCH_LIST}\n${SEARCH_LIST_ELEMENT}"
  done

  SEARCH_LIST="$(echo "${SEARCH_LIST}" | sed -e '/^$/d')"

  COMMAND="${1}"
  QUERY="${2}"
  
  if [ -z "${QUERY}" ] && [ ! -z "${EMPTY_QUERY_COMMAND}" ]; then
    sh -c "${EMPTY_QUERY_COMMAND}"
    return $?
  fi

  SKIM_PROMPT="❱ "
  test ! -z "${SEARCH_PROMPT}" && SKIM_PROMPT="${SEARCH_PROMPT} ${SKIM_PROMPT}"

  SKIM_CMD_PROMPT="❱ "
  test ! -z "${CMD_PROMPT}" && SKIM_CMD_PROMPT="${CMD_PROMPT} ${SKIM_CMD_PROMPT}"

  RESULT=""
  if [ -z "${QUERY}" ]; then
    RESULT="$(echo "${SEARCH_LIST}" | skim --prompt="${SKIM_PROMPT}" --cmd-prompt="${SKIM_CMD_PROMPT}" --ansi)"
  else
    RESULT="$(echo "${SEARCH_LIST}" | skim -0 -1 --query "${QUERY}" --prompt="${SKIM_PROMPT}" --cmd-prompt="${SKIM_CMD_PROMPT}" --ansi)"
  fi

  if [ -n "${RESULT}" ]; then
    eval "${COMMAND} '${RESULT}'"
  fi
}

alias g='git'

alias k='kubectl'
alias kk='echo "$(kubectl config current-context) / $(kubectl config view --minify | grep namespace | cut -d" " -f6 | tr -d "\n")"'
alias kx="_KUBECTX_FORCE_COLOR=1 kubectx | SEARCH_PROMPT='Kube context' seaunch kubectx"
alias kn="_KUBECTX_FORCE_COLOR=1 kubens | SEARCH_PROMPT='Kube namespace' seaunch kubens"
#alias zj="zellij list-sessions | SEARCH_PROMPT='Zellij session' seaunch 'zellij attach --create'"

kube_finalizers_remove() {
  kubectl patch "${1}" "${2}" --type json --patch '[{"op":"remove","path":"/metadata/finalizers"}]'
}
