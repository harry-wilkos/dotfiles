function start_houdini
    # Start the sesinetd service
    sudo /etc/rc.d/init.d/sesinetd start
    # Run Houdini with any arguments passed to this function
    houdini $argv
end

