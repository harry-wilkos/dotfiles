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

    # System Package Updates
    command dnf upgrade --refresh --best --allowerasing
    command dnf update -v
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

    # Cleanup and Cache Clearing
    command dnf clean all -v
    command flatpak uninstall --unused -y
    command flatpak repair

    if test -d ~/.cache/thumbnails
        command rm -rf ~/.cache/thumbnails/*
    end

    set disabled_snaps (snap list --all | awk '/disabled/{print $1, $3}')
    if test -n "$disabled_snaps"
        command snap remove --purge $disabled_snaps
    end

    command rm -rf /tmp/*
    command journalctl --vacuum-time=2weeks

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
end
