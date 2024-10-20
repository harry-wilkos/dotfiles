# Function for greeting
function fish_greeting
    colorscript -r
end

# Check if running interactively
if status is-interactive
    # Check if Atuin exists before sourcing
    if test -f ~/.atuin/bin/env.fish
        atuin init fish | source
    end
end

# Initialize Starship
starship init fish | source

# Set Houdini user preferences
set -x HOUDINI_USER_PREF_DIR ~/.config/houdini20.0

# Initialize Homebrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add local paths to fish path
fish_add_path ~/.local/bin
fish_add_path ~/.spicetify
fish_add_path ~/.atuin/bin
fish_add_path /opt/hfs20.0.653/bin

# Cursor settings
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore

