function monster
    set MOUNT_POINT $HOME/Monster

    if test "$argv[1]" = -u
        # Unmounting logic
        if mountpoint -q $MOUNT_POINT
            # Get the current working directory
            set CURRENT_DIR (pwd)

            # Check if the current directory is within the mount point
            if string match -q "$MOUNT_POINT/*" "$CURRENT_DIR" || test "$CURRENT_DIR" = "$MOUNT_POINT"
                cd $HOME
                sleep 0.5
            end

            # Attempt to unmount
            umount $MOUNT_POINT
            if test $status -eq 0
                echo "Monster unmounted."
            else
                echo "Failed to unmount Monster."
            end
        else
            echo "Monster is not mounted."
        end
    else
        # Mounting logic
        if not mountpoint -q $MOUNT_POINT
            mount $MOUNT_POINT
            if test $status -eq 0
                echo "Monster mounted."
                cd $MOUNT_POINT
            else
                echo "Failed to mount Monster."
            end
        else
            echo "Monster is already mounted."
            cd $MOUNT_POINT
        end
    end
end

