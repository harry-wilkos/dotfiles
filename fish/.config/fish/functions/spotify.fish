function spotify
    flatpak run com.spotify.Client >/dev/null 2>&1 &
    disown
end
