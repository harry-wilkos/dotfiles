function monster
    set MOUNT_POINT ~/Monster

    if test "$argv[1]" = -u
        # Unmounting logic
        if mountpoint -q $MOUNT_POINT
            # If the current directory is inside the mount point, move out
            if string match -q $PWD "$MOUNT_POINT/*"
                cd ~
            end
            umount $MOUNT_POINT
            echo "Monster unmounted."
        else
            echo "Monster is not mounted."
        end
    else
        # Mounting logic
        if not mountpoint -q $MOUNT_POINT
            mount $MOUNT_POINT
            # Check if the mount was successful
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
