function start_houdini
    # Save the current directory
    set current_dir (pwd)

    # Change to the Houdini directory and source the setup
    cd /opt/hfs20.0.653
    source /opt/hfs20.0.653/houdini_setup_bash

    # Start the sesinetd service
    sudo /etc/rc.d/init.d/sesinetd start

    # Run Houdini with any arguments passed to this function
    houdini $argv

    # Return to the original directory
    cd $current_dir
end

