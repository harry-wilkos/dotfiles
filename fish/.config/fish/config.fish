# Setup fish greeting
function fish_greeting
    colorscript -r
end

# Setup Atuin
if status is-interactive
    if test -f ~/.atuin/bin/env.fish
        atuin init fish | source
    end
end

# Setup python env auto-sourcing
function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
        set cwd (pwd -P)

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

# Setup Starship
starship init fish | source

# Initialize Homebrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Cursor settings
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore

# Add local paths to fish path
fish_add_path ~/.local/bin
fish_add_path ~/.spicetify
fish_add_path ~/.atuin/bin
fish_add_path /opt/hfs20.0.653/bin
fish_add_path /opt/Nuke15.0v3
source /home/Harry/.cargo/env.fish

# Set Python Path
set -x PYTHONPATH "/opt/hfs20.0.653/houdini/python3.10libs/:/opt/hfs20.0.653/python/lib/python3.10/site-packages:$PYTHONPATH"

# Set Houdini user preferences
set -x HOUDINI_USER_PREF_DIR ~/.config/houdini20.0
set -x LD_PRELOAD /opt/hfs20.0.653/dsolib/libjemalloc.so
set -x QTWEBENGINE_CHROMIUM_FLAGS --no-sandbox

# Set Nuke user preferences
set -x NUKE_PATH ~/.config/Nuke15.0
set -x QT_SCALE_FACTOR 1.15
