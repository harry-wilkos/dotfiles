function update_all
    brew update -v
    brew upgrade -v

    sudo update ~/.repos
    brew cleanup -v
    echo ==============================
    df -h
    echo ==============================

end
