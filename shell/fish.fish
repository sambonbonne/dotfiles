# disable greeting message
function fish_greeting
    # do nothing
end

# load common configuration (if compatible)
set PROFILE_CONFIG_PATH "$HOME/.config/profile"
function load_sh_config
    source "$PROFILE_CONFIG_PATH/$argv[1].sh"
end

load_sh_config aliases

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.npm/bin
fish_add_path ~/.composer/vendor/bin
fish_add_path ~/.krew/bin

# setup prompt
if command -v starship 2>&1 >/dev/null
    starship init fish | source
else
    function fish_prompt -d "Basic prompt"
        printf '%s@%s %s%s%s ❯ ' $USER $hostname (set_color --bold) (prompt_pwd) (set_color normal)
    end

    echo "Starship is not installed, basic prompt set."
end

# setup default editor
if command -v hx >/dev/null
    set -gx EDITOR hx
else if command -v helix >/dev/null
    set -gx EDITOR helix
else if command -v kak >/dev/null
    set -gx EDITOR kak
else if command -v kakoune >/dev/null
    set -gx EDITOR kakoune
else if command -v nvim >/dev/null
    set -gx EDITOR nvim
else if command -v vim >/dev/null
    set -gx EDITOR vim
end

# setup key bindings
fish_vi_key_bindings
bind --mode insert ctrl-space forward-word
bind --mode insert alt-space accept-autosuggestion
bind --mode insert ctrl-a beginning-of-line
bind --mode insert ctrl-e end-of-line
bind --mode default \; edit_command_buffer

# setup plugins manager
if status --is-interactive && ! type -q fisher 2>/dev/null
    echo "Installing Fisher"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
    fisher update
end

# Setup franciscolourenco/done
set -U __done_min_cmd_duration 5000 # duration in ms from which a notification is sent
set -U __done_exclude '^(d(istro)?box|h(eli)?x|k9s|kak(oune)?|(n(eo)?)?vim|time|tmu?x|toolbo?x|vim?|wl-(copy|paste)|z(elli)?j)' # commands to exclude
set -U __done_notification_urgency_level low # use low level notification for successful commands
set -U __done_notification_urgency_level_failure normal # use normal level notification for failed commands
set -U __done_notification_command "echo \$title \$message"
set -U __done_allow_nongraphical 1
