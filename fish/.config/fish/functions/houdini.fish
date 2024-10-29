function start_houdini
    # Start the sesinetd service
    sudo /opt/hfs20.0.653/houdini/sbin/sesinetd.startup start

    # Run Houdini with any arguments passed to this function
    houdini $argv

    # Return to the original directory
    cd $current_dir
end

