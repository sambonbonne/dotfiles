function chpwd() {
  emulate -L zsh

  if command -v exa >/dev/null; then
    exa --all --long --git --classify --group-directories-first --time-style="long-iso"
  else
    ls -lAh --color=always

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git st -u ./
    fi
  fi
}
