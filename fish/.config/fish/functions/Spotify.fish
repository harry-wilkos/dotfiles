function Spotify
    spotify >/dev/null 2>&1 &
    disown
end
