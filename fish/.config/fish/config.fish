set -gx TERM xterm-256color

if type -q gitui
    alias gi gitui
end

if type -q exa
    alias l exa
    alias ll "exa -l"
    alias lla "ll -a"
end

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin

set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# intellij idea
fish_add_path "/home/npatel/.jdks/openjdk-24.0.1/bin/"
fish_add_path "/home/npatel/.local/share/JetBrains/Toolbox/apps/intellij-idea-community-edition/plugins/maven/lib/maven3/bin/"
