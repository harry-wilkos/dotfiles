function update_all
    brew cleanup -v
    brew update -v
    brew upgrade -v
    sudo update ~/.repos
    echo ==============================
    df -h
    echo ==============================

end
