function update
    # Ensure the function is run with sudo
    if not test (id -u) -eq 0
        echo "This function must be run as root. Please use sudo."
        return 1
    end

    # Check for a directory argument
    set repo_dir $argv[1]
    if test -z "$repo_dir"
        echo "No directory specified. Use: sudo update <directory>"
        return 1
    end

    # Replace `~` with `$HOME` to point to the correct user's home directory
    if test "$repo_dir" = "~"
        set repo_dir $HOME
    end

    # Expand the path if it's a relative path
    set repo_dir (realpath $repo_dir)

    # Cleanup and Cache Clearing
    command dnf clean all -v
    command flatpak uninstall --unused -y
    command flatpak repair

    # Cleaning up User Cache Directories
    if test -d ~/.cache
        command rm -rf ~/.cache/*
    end


    # Clear other common cache directories
    yes | trash-empty --all-users -v

    # Cleaning up temporary files in /tmp
    command rm -rf /tmp/*

    # Vacuuming Journal Logs
    command journalctl --vacuum-time=2weeks

    # Remove systemd tmpfiles
    command systemd-tmpfiles --clean

    # System Package Updates
    command dnf upgrade --refresh --best -y
    command dnf update-minimal -v
    command flatpak update -y

    # Docker Updates
    if type -q docker-compose
        echo ==============================
        echo "Checking for Docker Compose files..."
        echo ==============================
        for compose_file in (find ~ -name "docker-compose.yml")
            set compose_dir (dirname $compose_file)
            echo ==============================
            echo "Pulling Docker Compose images in $compose_dir..."
            echo ==============================

            cd $compose_dir
            docker-compose pull
        end
    end

    if type -q docker
        echo ==============================
        echo "Pulling individual Docker images..."
        echo ==============================

        for image in (docker images --format "{{.Repository}}:{{.Tag}}")
            echo ==============================
            echo "Pulling $image..."
            echo ==============================
            docker pull $image
        end
        echo ==============================
        echo "Removing unused Docker images and volumes..."
        echo ==============================

        docker image prune -af
        docker volume prune -f
    end


    # Git Pull for Repositories
    if test -d "$repo_dir"
        for dir in (find $repo_dir -type d -name ".git" -exec dirname {} \;)
            echo ==============================
            echo "Updating Git repository in $dir..."
            echo ==============================

            cd $dir
            git pull

            # Prune old references
            echo ==============================
            echo "Pruning old references in $dir..."
            echo ==============================

            git remote prune origin

            # Optimize repository
            echo ==============================
            echo "Optimizing repository in $dir..."
            echo ==============================

            git gc
        end
    else
        echo "The specified directory does not exist."
        return 1
    end

    # Rebuild force blur
    cd "$repo_dir/kwin-effects-forceblur/build"
    command rm -r *
    command cmake ../ -DCMAKE_INSTALL_PREFIX=/usr
    command make
    command make install

    # Rebuild better discord
    "$repo_dir/BetterDiscord"
    command pnpm build
    command pnpm inject
end
