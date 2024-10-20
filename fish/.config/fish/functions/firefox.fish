function firefox
    set urlregex '^(https?://)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(.[a-zA-Z]{2,})?$'

    if test -z "$argv"
        xdg-open www.google.co.uk >/dev/null 2>&1 &
        disown
    else
        if echo "$argv" | string match -r $urlregex >/dev/null
            xdg-open $argv >/dev/null 2>&1 &
            disown
        else
            xdg-open "https://www.google.com/search?q=$argv" >/dev/null 2>&1 &
            disown
        end
    end
end
