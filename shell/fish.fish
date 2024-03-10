set PROFILE_CONFIG_PATH "$HOME/.config/profile"
function load_sh_config
  source "$PROFILE_CONFIG_PATH/$argv[1].sh"
end

load_sh_config "aliases"

if command -v starship 2>&1 >/dev/null
  starship init fish | source
else
  function fish_prompt -d "Basic prompt"
    printf '%s@%s %s%s%s ❯ ' $USER $hostname (set_color --bold) (prompt_pwd) (set_color normal)
  end

  echo "Starship is not installed, basic prompt set."
end
