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
set -x LD_PRELOAD /opt/hfs20.0.653/dsolib/libjemalloc.so

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

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
        set cwd (pwd -P)

        # Array of possible virtual environment folder names
        set venv_folders env venv .env .venv

        while string match "$gitdir*" "$cwd" &>/dev/null
            for venv_folder in $venv_folders
                if test -e "$cwd/$venv_folder/bin/activate.fish"
                    source "$cwd/$venv_folder/bin/activate.fish" &>/dev/null
                    return
                end
            end
            set cwd (path dirname "$cwd")
        end
    end
    if test -n "$VIRTUAL_ENV"
        deactivate
    end
end
