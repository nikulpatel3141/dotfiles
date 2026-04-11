fnm env --use-on-cd | source

# Auto-install and default latest LTS node if none is installed yet
if not command -q node
    echo "fnm: no node found — installing latest LTS..."
    fnm install --lts
    fnm default lts-latest
    fnm env --use-on-cd | source
end
