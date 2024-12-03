function nuke
     Nuke15.0 --nukex $argv >/dev/null 2>&1 &
     disown
     sleep 1
     rm -r ~/nuke

end

