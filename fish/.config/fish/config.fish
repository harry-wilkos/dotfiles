function fish_greeting
    colorscript -r
end

starship init fish | source
atuin init fish | source

set -x HOUDINI_USER_PREF_DIR ~/.config/houdini20.0
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source ~/.atuin/bin/env.fish
fish_add_path ~/.local/bin
fish_add_path ~/.spicetify
fish_add_path /opt/hfs20.0.653/bin

set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore
