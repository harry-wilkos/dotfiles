function update
    # Ensure the function is run with sudo
    if not test (id -u) -eq 0
        echo "This function must be run as root. Please use sudo."
        return 1
    end

    # System Package Updates
    command dnf upgrade --refresh --best --allowerasing
    command dnf update -v
    command flatpak update -y

    # Docker Updates
    if type -q docker-compose
        echo "Checking for Docker Compose files..."
        for compose_file in (find ~ -name "docker-compose.yml")
            set compose_dir (dirname $compose_file)
            echo "Pulling Docker Compose images in $compose_dir..."
            cd $compose_dir
            docker-compose pull
        end
    end

    if type -q docker
        echo "Pulling individual Docker images..."
        for image in (docker images --format "{{.Repository}}:{{.Tag}}")
            echo "Pulling $image..."
            docker pull $image
        end

        echo "Removing unused Docker images and volumes..."
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

end


