function discord
    sh /usr/lib64/discord/wrapper.sh >/dev/null 2>&1 &
    disown
end
