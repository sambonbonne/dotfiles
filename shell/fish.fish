if command -v starship
  starship init fish | source
else
  function fish_prompt -d "Basic prompt"
    printf '%s@%s %s%s%s ❯ ' $USER $hostname (set_color --bold) (prompt_pwd) (set_color normal)
  end

  echo "Starship is not installed, basic prompt set."
end
