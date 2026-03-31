
function __complete_terraform
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /home/linuxbrew/.linuxbrew/Cellar/terraform/1.13.1/bin/terraform
end
complete -f -c terraform -a "(__complete_terraform)"

