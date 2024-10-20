function sudo
    # Check if any arguments were passed
    if test (count $argv) -eq 0
        echo "Usage: sudo <command>"
        return 1
    end
    
    # Check if the first argument is a flag (starts with -)
    if test "$argv[1]" = "-i" -o "$argv[1]" = "--interactive"
        # Pass the flag directly to the original sudo command
        command sudo fish
        return
    end
       if functions -q $argv[1]
        set argv fish -c "$argv"
    end
    command sudo $argv 
end
