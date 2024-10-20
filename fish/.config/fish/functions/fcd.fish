function fcd
    set dir (find . -type d | fzf)
    if test -n "$dir"
        cd "$dir"
    end
end

