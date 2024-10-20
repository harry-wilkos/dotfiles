function parker
    if test "$argv[1]" = -d
        wg-quick down parker

    else
        wg-quick up parker
    end
end
