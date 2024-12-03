function update_all
    sudo update ~/.repos
    brew cleanup -v
    flatpak uninstall --unused -y
    flatpak repair
    brew update -v
    brew upgrade -v
    flatpak update -y
    spicetify backup apply
    echo ==============================
    df -h
    echo ==============================

end
