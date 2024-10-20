function mongodb-compass
    flatpak run com.mongodb.Compass >/dev/null 2>&1 &
    disown
end
