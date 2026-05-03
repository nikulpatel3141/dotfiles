function v
    if not isatty stdin
        nvim -
    else
        nvim $argv
    end
end
